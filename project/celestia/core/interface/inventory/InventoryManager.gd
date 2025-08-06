extends Control

@onready var slots_group = $SlotsGroup
@onready var popup_tooltip = $PopupTooltip

var inventory: Array[ItemStack] = []
var _stack_in_cursor: ItemStack
var cursor_click_origin_slot: int
var sprite_to_cursor: Sprite2D = null

# GODOT
func _ready() -> void:
	clear_all_inventory()
	EventBus.client_inventory.connect('left_click_slot', Callable(self, '_handle_left_click_on_slot'))
	EventBus.client_inventory.connect('middle_click_slot', Callable(self, '_handle_middle_click_on_slot'))
	EventBus.client_inventory.connect('right_click_slot', Callable(self, '_handle_right_click_on_slot'))


func _input(_event):
	update_cursor_sprite_position()

# GETTERS AND SETTERS
func get_stack_in_inventory(pos: int) -> ItemStack:
	return inventory[pos]


func get_stack_in_cursor() -> ItemStack:
	return _stack_in_cursor

# MAIN
func _on_inventory_closed() -> void:
	if _stack_in_cursor != null and _stack_in_cursor.get_amount() > 0:
		if cursor_click_origin_slot < 46:
			add_item_to_backpack(_stack_in_cursor)
		else:
			drop_item_players_foot(_stack_in_cursor)
		_stack_in_cursor = null
		clear_sprite_to_cursor()


func update_all_inventory() -> void:
	# Updates EACH of the slots in your inventory by emptying or rendering them
	for index in range(46):
		var slot = slots_group.get_child(index)
		if inventory[index].get_amount() == 0:
			slot.clear_slot()
			continue
		slot.render_slot(inventory[index])


func clear_all_inventory() -> void:
	for c in slots_group.get_children():
		inventory.append(ItemStack.get_empty_stack())
	update_all_inventory()


func is_full() -> bool:
	for c in range(12, 42):  # Slots for backpack
		var slot: ItemStack = inventory[c]
		if slot.get_amount() < slot.get_item().get_max_stack():
			return false
	return true


func get_stackable_index(item_id: String) -> int:
	for index in range(12, 42):  # Slots for backpack
		var invent_item: BaseItem = inventory[index].get_item()
		if invent_item.get_id() == item_id and invent_item.get_max_stack() > 1:
			return index
	return -1


func drop_item_in_position(stack: ItemStack, pos: Vector2):
	# Drops an item in a specific position
	var dropped_item = preload('res://core/items/custom/DroppedItem.tscn')
	var drop = dropped_item.instantiate()
	drop.initialize(stack)
	get_tree().root.add_child(drop)
	drop.global_position = pos


func drop_item_players_foot(stack: ItemStack):
	# Drops an item at the player's feet
	var player = get_parent().get_parent().get_parent()
	var at_pos = player.global_position
	drop_item_in_position(stack, at_pos)


func add_item_to_bp_new_slot(stack: ItemStack):
	for index in range(12, 42):  # Slots for backpack
		if inventory[index].get_amount() == 0:
			inventory[index] = stack
			slots_group.get_child(index).render_slot(inventory[index])
			return
	drop_item_players_foot(stack)


func add_item_to_backpack(stack: ItemStack) -> void:
	# Adds an item to the inventory, stacking, creating or ignoring it
	var remaining_amount = 0
	var stackable_index = get_stackable_index(stack.get_item().get_id())
	if not stackable_index < 0:  # Or: >= 0
		remaining_amount = inventory[stackable_index].add_amount_safe(stack.get_amount())
		slots_group.get_child(stackable_index).render_slot(inventory[stackable_index])
	else:
		remaining_amount = stack.get_amount()
	# As long as there is an remaining amount, try adding
	while remaining_amount > 0:
		var item_max_stack: int = stack.get_item().get_max_stack()
		if remaining_amount <= item_max_stack:
			add_item_to_bp_new_slot(ItemStack.new(
				stack.get_item(),
				remaining_amount
			))
			return
		else:
			add_item_to_bp_new_slot(ItemStack.new(
				stack.get_item(),
				item_max_stack
			))
			remaining_amount -= item_max_stack

# CURSOR HANDLERS
func set_sprite_to_cursor(splited_id: Array):
	sprite_to_cursor = Sprite2D.new()
	sprite_to_cursor.texture = load('res://assets/%s/textures/items/%s.png' % splited_id)
	add_child(sprite_to_cursor)
	update_cursor_sprite_position()


func clear_sprite_to_cursor():
	if sprite_to_cursor == null: return
	sprite_to_cursor.queue_free()
	sprite_to_cursor = null


func update_cursor_sprite_position():
	if _stack_in_cursor == null or _stack_in_cursor.get_amount() <= 0: return
	sprite_to_cursor.global_position = get_global_mouse_position()


func _handle_left_click_on_slot(slot):
	var slot_index = slot.get_index()
	var slot_stack = inventory[slot_index]
	# Empty cursor
	if _stack_in_cursor == null or _stack_in_cursor.get_amount() <= 0:
		if slot_stack.get_amount() > 0:
			_stack_in_cursor = slot_stack
			cursor_click_origin_slot = slot_index
			inventory[slot_index] = ItemStack.get_empty_stack()
			slot.clear_slot()
			set_sprite_to_cursor(_stack_in_cursor.get_item().get_splited_id())
	# Cursor loaded and slot empty
	elif slot_stack.get_amount() <= 0:
		inventory[slot_index] = _stack_in_cursor
		_stack_in_cursor = null
		clear_sprite_to_cursor()
	# Cursor loaded and equal to slot
	elif _stack_in_cursor.get_item().get_id() == slot_stack.get_item().get_id():
		var extra = slot_stack.add_amount_safe(_stack_in_cursor.get_amount())
		if extra <= 0:
			_stack_in_cursor = null
			clear_sprite_to_cursor()
		else:
			_stack_in_cursor.set_amount(extra)
	# Cursor loaded, but different from the slot
	else:
		var temp = inventory[slot_index]
		inventory[slot_index] = _stack_in_cursor
		_stack_in_cursor = temp
	update_all_inventory()


func _handle_middle_click_on_slot(slot):
	var slot_index = slot.get_index()
	var slot_stack = inventory[slot_index]
	if slot_stack.get_amount() > 0:
		inventory[slot_index] = ItemStack.get_empty_stack()
		drop_item_players_foot(slot_stack)
		slot.clear_slot()


func _handle_right_click_on_slot(slot):
	var slot_index = slot.get_index()
	var slot_stack = inventory[slot_index]
	# Empty cursor
	if _stack_in_cursor == null or _stack_in_cursor.get_amount() <= 0:
		if slot_stack.get_amount() > 0:
			var take_amount := int(ceil(slot_stack.get_amount() / 2.0))
			_stack_in_cursor = ItemStack.new(slot_stack.get_item(), take_amount)
			cursor_click_origin_slot = slot_index
			slot_stack.set_amount(slot_stack.get_amount() - take_amount)
			set_sprite_to_cursor(_stack_in_cursor.get_item().get_splited_id())
	# Cursor loaded and slot empty
	elif slot_stack.get_amount() <= 0:
		inventory[slot_index] = ItemStack.new(_stack_in_cursor.get_item(), 1)
		_stack_in_cursor.set_amount(_stack_in_cursor.get_amount() - 1)
	# Cursor loaded and equal to slot
	elif _stack_in_cursor.get_item().get_id() == slot_stack.get_item().get_id():
		var extra = slot_stack.add_amount_safe(1)
		if extra == 0:
			_stack_in_cursor.set_amount(_stack_in_cursor.get_amount() - 1)
		else:
			_stack_in_cursor.set_amount(extra)
	# Cursor loaded, but different from the slot
	else:
		var temp = inventory[slot_index]
		inventory[slot_index] = _stack_in_cursor
		_stack_in_cursor = temp
	# 
	if _stack_in_cursor and _stack_in_cursor.get_amount() <= 0:
		_stack_in_cursor = null
		clear_sprite_to_cursor()
	update_all_inventory()
