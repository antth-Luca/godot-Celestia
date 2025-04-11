extends Control

const ABSTRACT_ITEM = preload("res://components/items/abstract_item.tscn")

var main_inventory = []

var stack_in_cursor: ItemStack
var cursor_click_origin_slot: int
var sprite_to_cursor: Sprite2D = null

# Init
func _ready() -> void:
	clear_inventory()
	connect_slots()


func clear_inventory() -> void:
	# Esvazia TODOS os slots que estiverem dentro do inventário
	var count_slots = get_child_count()
	for c in count_slots:
		main_inventory.append(ItemStack.get_empty_slot())
	update_inventory()


func connect_slots():
	# Conecta CADA UM dos slots que estiverem dentro do inventário à uma função
	for slot in get_children():
		slot.gui_input.connect(_on_slot_gui_input.bind(slot))


func on_inventory_closed():
# Volta a pilha do cursor ao inventário 
	if stack_in_cursor != null and stack_in_cursor.amount > 0:
		if cursor_click_origin_slot < main_inventory.size():
			add_item_to_invent(stack_in_cursor)
		else:
			drop_item(stack_in_cursor)
	# Limpa variáveis do cursor
	stack_in_cursor = null
	clear_sprite_to_cursor()
	update_inventory()


func is_full() -> bool:
	for slot in main_inventory:
		if slot.amount < slot.item_class.max_stack:
			return false
	return true


# Inventory and slot handlers
func update_inventory():
	# Atualiza CADA UM dos slots que estiverem dentro do inventário, esvaziando, ou renderizando
	for index in main_inventory.size():
		var slot = get_child(index)
		if main_inventory[index].amount <= 0:
			main_inventory[index] = ItemStack.get_empty_slot()
			clear_slot(slot)
			continue
		render_slot(slot, main_inventory[index])


func clear_slot(slot) -> void:
	# Esvazia um slot específico
	slot.get_node('Sprite').visible = false
	slot.get_node('LabelAmount').visible = false


func render_slot(slot, item_slot: ItemStack) -> void:
	# Renderiza graficamente o slot (Sprite de item e valor da pilha)
	var sprite = slot.get_node('Sprite')
	var labelAmount = slot.get_node('LabelAmount')

	sprite.texture = load("res://assets/textures/items/" + item_slot.item_class.icon_name + ".png")
	sprite.visible = true
	labelAmount.text = str(item_slot.amount)
	labelAmount.visible = item_slot.amount > 1


func has_item(item_name: String) -> bool:
	# Verfica se há ou não um item em CADA UM dos slots do inventário
	for item in main_inventory:
		if item.item_class.item_name == item_name:
			return true
	return false


func get_stackable_index(item_name: String) -> int:
	for index in main_inventory.size():
		var inv_stack = main_inventory[index]
		if inv_stack.item_class.item_name == item_name and inv_stack.item_class.max_stack > 1:
			return index
	return -1


func add_item_to_invent(stack: ItemStack) -> void:
	# Adiciona um item no inventário, já cuidando de empilhar, criar ou ignorar
	if stack.amount < 1: return
	if has_item(stack.item_class.item_name) and stack.item_class.max_stack > 1:
		var extra = main_inventory[get_stackable_index(stack.item_class.item_name)].add_amount_safe(stack.amount)
		if extra > 0:
			stack.amount = extra
			add_item_in_new_slot(stack)
		update_inventory()
		return
	add_item_in_new_slot(stack)


func add_item_in_new_slot(stack: ItemStack):
	var is_added = false
	for index in main_inventory.size():
		if main_inventory[index].amount <= 0:
			main_inventory[index] = stack
			is_added = true
			update_inventory()
			break
	if !is_added: drop_item(stack)


func remove_item_to_invent(index: int, amount: int) -> void:
	# Remove uma quantia de um slot, sem muitas verificações
	if amount < 1: return
	main_inventory[index].amount -= amount
	update_inventory()


func drop_item(stack: ItemStack, at_position: Vector2 = Vector2(0, 0)):
	var abstract_item = ABSTRACT_ITEM.instantiate()
	abstract_item.initialize(stack)
	get_tree().root.add_child(abstract_item)
	abstract_item.global_position = at_position

# Inventory cursor handlers
func _on_slot_gui_input(event: InputEvent, slot):
	# Separa e direciona os cliques direito e esquerdo para suas funções
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			handle_left_click(slot)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			handle_right_click(slot)


func handle_left_click(slot):
	# Manuseio de slots com clique esquerdo, ações totais
	var slot_index = slot.get_index()
	var slot_stack = main_inventory[slot_index]

	# Se não estamos segurando nada
	if stack_in_cursor == null or stack_in_cursor.amount <= 0:
		if slot_stack.amount > 0:
			stack_in_cursor = slot_stack
			cursor_click_origin_slot = slot_index
			main_inventory[slot_index] = ItemStack.get_empty_slot()
			clear_slot(slot)
			set_sprite_to_cursor(stack_in_cursor.item_class.icon_name)
	# Segurando algo
	else:
		# Slot do inventátio vazio
		if slot_stack.amount <= 0:
			main_inventory[slot_index] = stack_in_cursor
			stack_in_cursor = null
			clear_sprite_to_cursor()
		# Slot do inventário é igual ao do cursor
		elif stack_in_cursor.item_class.item_name == slot_stack.item_class.item_name and not slot_stack.amount + stack_in_cursor.amount > stack_in_cursor.item_class.max_stack:
			slot_stack.amount += stack_in_cursor.amount
			stack_in_cursor = null
			clear_sprite_to_cursor()
		# Slot do inventário é diferente do cursor
		else:
			var temp = main_inventory[slot_index]
			main_inventory[slot_index] = stack_in_cursor
			stack_in_cursor = temp
			clear_sprite_to_cursor()
	update_inventory()


func handle_right_click(slot):
	# Manuseio de slots com clique direito, ações parciais
	var slot_index = slot.get_index()
	var slot_stack = main_inventory[slot_index]

	# Se não estamos segurando nada
	if stack_in_cursor == null or stack_in_cursor.amount <= 0:
		if slot_stack.amount > 0:
			var take_amount := int(ceil(slot_stack.amount / 2.0))
			stack_in_cursor = ItemStack.new(slot_stack.item_class, take_amount)
			cursor_click_origin_slot = slot_index
			slot_stack.amount -= take_amount
			set_sprite_to_cursor(stack_in_cursor.item_class.icon_name)
	# Segurando algo
	else:
		# Slot do inventátio vazio
		if slot_stack.amount <= 0:
			main_inventory[slot_index] = ItemStack.new(stack_in_cursor.item_class, 1)
			stack_in_cursor.amount -= 1
		# Slot do inventário é igual ao do cursor
		elif slot_stack.item_class.item_name == stack_in_cursor.item_class.item_name and not slot_stack.amount + stack_in_cursor.amount > stack_in_cursor.item_class.max_stack:
			slot_stack.amount += 1
			stack_in_cursor.amount -= 1

	if stack_in_cursor and stack_in_cursor.amount <= 0:
		stack_in_cursor = null
		clear_sprite_to_cursor()
	update_inventory()


func set_sprite_to_cursor(icon_name: String):
	sprite_to_cursor = Sprite2D.new()
	sprite_to_cursor.texture = load("res://assets/textures/items/" + icon_name + ".png")
	add_child(sprite_to_cursor)
	update_sprite_to_cursor()


func clear_sprite_to_cursor():
	if sprite_to_cursor == null: return
	sprite_to_cursor.queue_free()
	sprite_to_cursor = null


func update_sprite_to_cursor():
	if stack_in_cursor == null or stack_in_cursor.amount <= 0: return
	sprite_to_cursor.global_position = get_global_mouse_position()


func _input(_event):
	update_sprite_to_cursor()
