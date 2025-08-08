extends Control

@onready var slots_group := $SlotsGroup
@onready var popup_tooltip := $PopupTooltip

var cursor := CursorManager.new()
var inventory: Array[ItemStack] = []

# GODOT
func _ready() -> void:
	clear_all_inventory()
	EventBus.client_inventory.connect('left_click_slot', Callable(self, '_handle_left_click_on_slot'))
	EventBus.client_inventory.connect('middle_click_slot', Callable(self, '_handle_middle_click_on_slot'))
	EventBus.client_inventory.connect('right_click_slot', Callable(self, '_handle_right_click_on_slot'))


func _input(_event):
	if not cursor.is_cursor_stack_empty():
		cursor.update_cursor_sprite_position(get_global_mouse_position())

# GETTERS AND SETTERS
func get_stack_in_inventory(pos: int) -> ItemStack:
	return inventory[pos]

# MAIN
func _on_inventory_closed() -> void:
	if not cursor.is_cursor_stack_empty():
		add_item_to_backpack(cursor.get_cursor_stack())
		cursor.clear_cursor()


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
		var slot_stack: ItemStack = inventory[c]
		if slot_stack.get_amount() < slot_stack.get_item().get_max_stack():
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

# HANDLERS
func _handle_left_click_on_slot(slot: Slot):
	var slot_index: int = slot.get_index()
	var slot_stack: ItemStack = inventory[slot_index]
	var slot_amount: int = slot_stack.get_amount()
	var slot_item: BaseItem = slot_stack.get_item()
	var slot_can_unequip: bool = slot_item != null and slot_item.can_unequip(slot)

	var cursor_stack: ItemStack = cursor.get_cursor_stack()
	var cursor_can_equip: bool = cursor_stack.get_item().can_equip(slot)

	# Case 1: Empty cursor
	if cursor.is_cursor_stack_empty():
		if slot_amount > 0 and slot_can_unequip:
			cursor.set_click(slot_stack, slot_index, self)
			inventory[slot_index] = ItemStack.get_empty_stack()

	# Case 2: Cursor loaded and slot empty
	elif slot_amount <= 0:
		if cursor_can_equip:
			inventory[slot_index] = cursor_stack
			cursor.clear_cursor()

	# Case 3: Cursor loaded and equal to slot
	elif cursor.is_equal_to(slot_stack):
		if slot_can_unequip and cursor_can_equip:
			var extra: int = slot_stack.add_amount_safe(cursor_stack.get_amount())
			if extra <= 0:
				cursor.clear_cursor()
			else:
				cursor_stack.set_amount(extra)

	# Case 4: Cursor loaded, but different from the slot
	else:
		if slot_can_unequip and cursor_can_equip:
			var temp: ItemStack = inventory[slot_index]
			inventory[slot_index] = cursor_stack
			cursor.set_click(temp, slot_index, self)

	update_all_inventory()


func _handle_middle_click_on_slot(slot: Slot):
	var slot_index: int = slot.get_index()
	var slot_stack: ItemStack = inventory[slot_index]

	if slot_stack.get_amount() > 0 and slot_stack.get_item().can_unequip(slot):
		inventory[slot_index] = ItemStack.get_empty_stack()
		drop_item_players_foot(slot_stack)

	update_all_inventory()


func _handle_right_click_on_slot(slot: Slot):
	var slot_index: int = slot.get_index()
	var slot_stack: ItemStack = inventory[slot_index]
	var slot_amount: int = slot_stack.get_amount()
	var slot_item: BaseItem = slot_stack.get_item()
	var slot_can_unequip: bool = slot_item != null and slot_item.can_unequip(slot)

	var cursor_stack: ItemStack = cursor.get_cursor_stack()
	var cursor_item: BaseItem = cursor_stack.get_item()
	var cursor_amount: int = cursor_stack.get_amount()
	var cursor_can_equip: bool = cursor_item.can_equip(slot)

	# Case 1: Empty cursor
	if cursor.is_cursor_stack_empty():
		if slot_amount > 0 and slot_can_unequip:
			var take_amount := int(ceil(slot_amount / 2.0))
			cursor.set_click(
				ItemStack.new(slot_item, take_amount),
				slot_index,
				self
			)
			slot_stack.set_amount(slot_amount - take_amount)

	# Case 2: Cursor loaded and slot empty
	elif slot_amount <= 0:
		if cursor_can_equip:
			inventory[slot_index] = ItemStack.new(cursor_item, 1)
			cursor_stack.set_amount(cursor_amount - 1)

	# Case 3: Cursor loaded and equal to slot
	elif cursor.is_equal_to(slot_stack):
		if slot_can_unequip and cursor_can_equip:
			var extra = slot_stack.add_amount_safe(1)
			if extra == 0:
				cursor_stack.set_amount(cursor_amount - 1)
			else:
				cursor_stack.set_amount(extra)

	# Case 4: Cursor loaded, but different from the slot
	else:
		if slot_can_unequip and cursor_can_equip:
			var temp: ItemStack = inventory[slot_index]
			inventory[slot_index] = cursor_stack
			cursor.set_click(temp, slot_index, self)

	# If the cursor is empty, clear it.
	if cursor.is_cursor_stack_empty():
		cursor.clear_cursor()

	update_all_inventory()
