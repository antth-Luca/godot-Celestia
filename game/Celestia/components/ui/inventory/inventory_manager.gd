extends Control

const ABSTRACT_ITEM = preload("res://components/items/abstract_item.tscn")
const TOTAL_SLOTS: int = 46
const SLOT_INDEX_RANGES = {
	'equip_slots': [0, 3],
	'relic_slots': [4, 9],
	'ammo_slots': [10, 11],
	'backpack_slots': [12, 41],
	'pocket_slots': [42, 45]
}

var inventory = []
var stack_in_cursor: ItemStack
var cursor_click_origin_slot: int
var sprite_to_cursor: Sprite2D = null

# Godot calls
func _ready() -> void:
	clear_inventory()
	connect_slots()


func _input(_event):
	update_sprite_to_cursor()

# Helpers
func clear_inventory() -> void:
	# Esvazia TODOS os slots que estiverem dentro do inventário
	for c in range(TOTAL_SLOTS):
		inventory.append(ItemStack.get_empty_slot())
	update_all_inventory()


func connect_slots() -> void:
	# Conecta CADA UM dos slots que estiverem dentro do inventário à uma função
	var slots_group = get_node("SlotsGroup")
	for c in range(TOTAL_SLOTS):
		var slot = slots_group.get_child(c)
		slot.gui_input.connect(_on_slot_gui_input.bind(slot))


func on_inventory_closed() -> void:
# Volta a pilha do cursor ao inventário 
	if stack_in_cursor != null and stack_in_cursor.amount > 0:
		if (cursor_click_origin_slot) < TOTAL_SLOTS:
			add_item_to_backpack(stack_in_cursor)
		else:
			drop_item_players_foot(stack_in_cursor)
	# Limpa variáveis do cursor
	stack_in_cursor = null
	clear_sprite_to_cursor()
	update_backpack_inventory()


func is_full() -> bool:
	for c in range(SLOT_INDEX_RANGES['backpack_slots'][0], SLOT_INDEX_RANGES['backpack_slots'][1] + 1):
		var slot = inventory[c]
		if slot.amount < slot.item_class.max_stack:
			return false
	return true


# UPDATE INVENTORY
func update_all_inventory() -> void:
	# Atualiza CADA UM dos slots que estiverem dentro do inventário, esvaziando ou renderizando
	var slots_group = get_node("SlotsGroup")
	for index in range(TOTAL_SLOTS):
		var slot = slots_group.get_child(index)
		if inventory[index].amount <= 0:
			inventory[index] = ItemStack.get_empty_slot()
			clear_slot(slot)
			continue
		render_slot(slot, inventory[index])


func update_backpack_inventory() -> void:
	# Atualiza CADA UM dos slots que estiverem dentro da mochila, esvaziando ou renderizando
	var slots_group = get_node("SlotsGroup")
	for index in range(SLOT_INDEX_RANGES['backpack_slots'][0], SLOT_INDEX_RANGES['backpack_slots'][1] + 1):
		var slot = slots_group.get_child(index)
		if inventory[index].amount <= 0:
			inventory[index] = ItemStack.get_empty_slot()
			clear_slot(slot)
			continue
		render_slot(slot, inventory[index])

# HANDLERS
func clear_slot(slot) -> void:
	# Esvazia um slot específico
	slot.get_node('Sprite').visible = false
	slot.get_node('LabelAmount').visible = false


func render_slot(slot, item_slot: ItemStack) -> void:
	# Renderiza graficamente o slot (Sprite de item e valor da pilha)
	var sprite = slot.get_node('Sprite')
	var labelAmount = slot.get_node('LabelAmount')

	sprite.texture = load("res://assets/textures/items/" + item_slot.item_class.item_key + ".png")
	sprite.visible = true
	labelAmount.text = str(item_slot.amount)
	labelAmount.visible = item_slot.amount > 1


func has_item_in_backpack(item_key: String) -> bool:
	# Verfica se há ou não um item em CADA UM dos slots do inventário
	for index in range(SLOT_INDEX_RANGES['backpack_slots'][0], SLOT_INDEX_RANGES['backpack_slots'][1] + 1):
		if inventory[index].item_class.item_key == item_key:
			return true
	return false


func get_stackable_index(item_key: String) -> int:
	for index in range(SLOT_INDEX_RANGES['backpack_slots'][0], SLOT_INDEX_RANGES['backpack_slots'][1] + 1):
		var inv_stack = inventory[index]
		if inv_stack.item_class.item_key == item_key and inv_stack.item_class.max_stack > 1:
			return index
	return -1


func add_item_to_backpack(stack: ItemStack) -> void:
	# Adiciona um item no inventário, já cuidando de empilhar, criar ou ignorar
	if stack.amount < 1: return
	if has_item_in_backpack(stack.item_class.item_key) and stack.item_class.max_stack > 1:
		var extra = inventory[get_stackable_index(stack.item_class.item_key)].add_amount_safe(stack.amount)
		if extra > 0:
			stack.amount = extra
			add_item_to_bp_new_slot(stack)
			return
		update_backpack_inventory()
		return
	add_item_to_bp_new_slot(stack)


func add_item_to_bp_new_slot(stack: ItemStack):
	var is_added = false
	for index in range(SLOT_INDEX_RANGES['backpack_slots'][0], SLOT_INDEX_RANGES['backpack_slots'][1] + 1):
		if inventory[index].amount <= 0:
			inventory[index] = stack
			is_added = true
			update_backpack_inventory()
			break
	if !is_added: drop_item_players_foot(stack)


func remove_item_to_invent(index: int, amount: int) -> void:
	# Remove uma quantia de um slot, sem muitas verificações
	if amount < 1: return
	inventory[index].amount -= amount
	update_backpack_inventory()


func drop_item_players_foot(stack: ItemStack):
	# Larga uma pilha de item no pé do jogador
	var player = get_parent().get_parent().get_parent()
	var at_pos = player.global_position
	drop_item_in_position(stack, at_pos)


func drop_item_in_position(stack: ItemStack, pos: Vector2):
	# Larga uma pilha de item em uma posição específica
	var abstract_item = ABSTRACT_ITEM.instantiate()
	abstract_item.initialize(stack)
	get_tree().root.add_child(abstract_item)
	abstract_item.global_position = pos
	

# Inventory cursor handlers
func _on_slot_gui_input(event: InputEvent, slot):
	# Separa e direciona os cliques direito e esquerdo para suas funções
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			handle_left_click(slot)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			handle_right_click(slot)
		elif event.button_index == MOUSE_BUTTON_MIDDLE:
			handle_middle_click(slot)


func handle_left_click(slot):
	# Manuseio de slots com clique esquerdo, ações totais
	var slot_index = slot.get_index()
	var slot_stack = inventory[slot_index]

	# Se não estamos segurando nada
	if stack_in_cursor == null or stack_in_cursor.amount <= 0:
		if slot_stack.amount > 0:
			stack_in_cursor = slot_stack
			cursor_click_origin_slot = slot_index
			inventory[slot_index] = ItemStack.get_empty_slot()
			clear_slot(slot)
			set_sprite_to_cursor(stack_in_cursor.item_class.item_key)
	# Segurando algo
	else:
		# Slot do inventátio vazio
		if slot_stack.amount <= 0:
			inventory[slot_index] = stack_in_cursor
			stack_in_cursor = null
			clear_sprite_to_cursor()
		# Slot do inventário é igual ao do cursor
		elif stack_in_cursor.item_class.item_key == slot_stack.item_class.item_key:
			if not slot_stack.amount + stack_in_cursor.amount > stack_in_cursor.item_class.max_stack:
				slot_stack.amount += stack_in_cursor.amount
				stack_in_cursor = null
				clear_sprite_to_cursor()
			else:
				var extra = slot_stack.add_amount_safe(stack_in_cursor.amount)
				stack_in_cursor.amount = extra
		# Slot do inventário é diferente do cursor
		else:
			var temp = inventory[slot_index]
			inventory[slot_index] = stack_in_cursor
			stack_in_cursor = temp
	update_all_inventory()


func handle_right_click(slot):
	# Manuseio de slots com clique direito, ações parciais
	var slot_index = slot.get_index()
	var slot_stack = inventory[slot_index]

	# Se não estamos segurando nada
	if stack_in_cursor == null or stack_in_cursor.amount <= 0:
		if slot_stack.amount > 0:
			var take_amount := int(ceil(slot_stack.amount / 2.0))
			stack_in_cursor = ItemStack.new(slot_stack.item_class, take_amount)
			cursor_click_origin_slot = slot_index
			slot_stack.amount -= take_amount
			set_sprite_to_cursor(stack_in_cursor.item_class.item_key)
	# Segurando algo
	else:
		# Slot do inventátio vazio
		if slot_stack.amount <= 0:
			inventory[slot_index] = ItemStack.new(stack_in_cursor.item_class, 1)
			stack_in_cursor.amount -= 1
		# Slot do inventário é igual ao do cursor
		elif slot_stack.item_class.item_key == stack_in_cursor.item_class.item_key and not slot_stack.amount + stack_in_cursor.amount > stack_in_cursor.item_class.max_stack:
			slot_stack.amount += 1
			stack_in_cursor.amount -= 1

	if stack_in_cursor and stack_in_cursor.amount <= 0:
		stack_in_cursor = null
		clear_sprite_to_cursor()
	update_all_inventory()


func handle_middle_click(slot):
	# Drop de slots com clique do scroll
	var slot_index = slot.get_index()
	var slot_stack = inventory[slot_index]

	if slot_stack.amount > 0:
		drop_item_players_foot(slot_stack)
		inventory[slot_index] = ItemStack.get_empty_slot()
		clear_slot(slot)
	update_all_inventory()


func set_sprite_to_cursor(item_key: String):
	sprite_to_cursor = Sprite2D.new()
	sprite_to_cursor.texture = load("res://assets/textures/items/" + item_key + ".png")
	add_child(sprite_to_cursor)
	update_sprite_to_cursor()


func clear_sprite_to_cursor():
	if sprite_to_cursor == null: return
	sprite_to_cursor.queue_free()
	sprite_to_cursor = null


func update_sprite_to_cursor():
	if stack_in_cursor == null or stack_in_cursor.amount <= 0: return
	sprite_to_cursor.global_position = get_global_mouse_position()
