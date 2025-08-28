extends Control

const TOTAL_SLOTS: int = 46
const BACKPACK_LAST_POSITION: int = 33

@onready var slots_group := $SlotsGroup
@onready var popup_tooltip := $PopupTooltip

var cursor := CursorManager.new(self)
var inventory: Array[ItemStack] = []

# GODOT
func _ready() -> void:
	clear_all_inventory()


func _input(event):
	if event is InputEventMouseMotion and not cursor.is_cursor_stack_empty():
		cursor.update_cursor_sprite_position(get_global_mouse_position())

# GETTERS AND SETTERS
# Nodes
func get_inventory_panel():
	return get_parent()


func get_slot(slot_index: int):
	return get_node('SlotsGroup').get_child(slot_index)


func get_popup_tooltip():
	return get_node('PopupTooltip')

# Inventory
func get_stack_in_inventory(pos: int) -> ItemStack:
	return inventory[pos]

# MAIN
func update_all_inventory() -> void:
	# Updates EACH of the slots in your inventory by emptying or rendering them
	for index in range(TOTAL_SLOTS):
		var slot = slots_group.get_child(index)
		if inventory[index].amount == 0:
			slot.clear_slot()
			continue
		slot.render_slot(inventory[index])


func clear_all_inventory() -> void:
	for c in slots_group.get_children():
		inventory.append(ItemStack.EMPTY)
	update_all_inventory()


func get_stackable_index(item_id: ResourceLocation) -> int:
	for index in range(BACKPACK_LAST_POSITION):  # Slots for backpack
		var invent_stack: ItemStack = inventory[index]
		if invent_stack.is_empty():
			return index
		else:
			var invent_item: BaseItem = invent_stack.item
			if invent_item.id == item_id and invent_stack.amount < invent_item.max_stack:
				return index
	return -1


func drop_item_in_position(stack: ItemStack, pos: Vector2):
	# Drops an item in a specific position
	var dropped_item = preload('res://core/items/DroppedItem.tscn')
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
	for index in range(BACKPACK_LAST_POSITION):  # Slots for backpack
		if inventory[index].amount == 0:
			inventory[index] = stack
			slots_group.get_child(index).render_slot(inventory[index])
			return
	drop_item_players_foot(stack)


func add_item_to_backpack(stack: ItemStack) -> void:
	# Adds an item to the inventory, stacking, creating or ignoring it
	var stackable_index = get_stackable_index(stack.item.id)
	if inventory[stackable_index].is_empty():
		inventory[stackable_index] = stack
		slots_group.get_child(stackable_index).render_slot(inventory[stackable_index])
		return

	var remaining_amount = inventory[stackable_index].add_amount_safe(stack.amount)
	slots_group.get_child(stackable_index).render_slot(inventory[stackable_index])
	# As long as there is an remaining amount, try adding
	while remaining_amount > 0:
		var item_max_stack: int = stack.item.max_stack
		if remaining_amount <= item_max_stack:
			add_item_to_bp_new_slot(ItemStack.new(
				stack.item,
				remaining_amount
			))
			return
		else:
			add_item_to_bp_new_slot(ItemStack.new(
				stack.item,
				item_max_stack
			))
			remaining_amount -= item_max_stack

# HANDLERS
func _on_inventory_closed() -> void:
	if not cursor.is_cursor_stack_empty():
		add_item_to_backpack(cursor.get_cursor_stack())
		cursor.clear_cursor()


func _handle_left_click_on_slot(slot: Slot):
	var slot_index: int = slot.get_index()
	var slot_stack: ItemStack = inventory[slot_index]
	var slot_amount: int = slot_stack.amount
	var slot_item: BaseItem = slot_stack.item
	var slot_can_unequip: bool = false if slot_stack.is_empty() else slot_item.can_unequip(slot)

	var cursor_stack: ItemStack = cursor.cursor_stack
	var cursor_item: BaseItem = cursor_stack.item
	var cursor_can_equip: bool = true if cursor_stack.is_empty() else cursor_stack.item.can_equip(slot)

	# Case 1: Empty cursor
	if cursor.is_cursor_stack_empty():
		if slot_amount > 0 and slot_can_unequip:
			cursor.set_click(slot_stack, slot_index)
			inventory[slot_index] = ItemStack.EMPTY
			slot.clear_slot()
			slot_item.on_unequip(slot)

	# Case 2: Cursor loaded and slot empty
	elif slot_amount <= 0:
		if cursor_can_equip:
			inventory[slot_index] = cursor_stack
			cursor.clear_cursor()
			slot.render_slot(cursor_stack)
			cursor_item.on_equip(slot)

	# Case 3: Cursor loaded and equal to slot
	elif cursor.is_equal_to(slot_stack):
		if slot_can_unequip and cursor_can_equip:
			var extra: int = slot_stack.add_amount_safe(cursor_stack.amount)
			if extra <= 0:
				cursor.clear_cursor()
			else:
				cursor_stack.amount = extra
			slot.render_slot(slot_stack)

	# Case 4: Cursor loaded, but different from the slot
	else:
		if slot_can_unequip and cursor_can_equip:
			var temp: ItemStack = inventory[slot_index]
			temp.item.on_unequip(slot)
			inventory[slot_index] = cursor_stack
			cursor_item.on_equip(slot)
			cursor.set_click(temp, slot_index)
			slot.render_slot(cursor_stack)


func _handle_middle_click_on_slot(slot: Slot):
	var slot_index: int = slot.get_index()
	var slot_stack: ItemStack = inventory[slot_index]

	if slot_stack.amount > 0 and slot_stack.item.can_unequip(slot):
		inventory[slot_index].item.on_unequip(slot)
		inventory[slot_index] = ItemStack.EMPTY
		drop_item_players_foot(slot_stack)
		slot.clear_slot()


func _handle_right_click_on_slot(slot: Slot):
	var slot_index: int = slot.get_index()
	var slot_stack: ItemStack = inventory[slot_index]
	var slot_amount: int = slot_stack.amount
	var slot_item: BaseItem = slot_stack.item
	var slot_can_unequip: bool = false if slot_stack.is_empty() else slot_item.can_unequip(slot)

	var cursor_stack: ItemStack = cursor.cursor_stack
	var cursor_item: BaseItem = cursor_stack.item
	var cursor_amount: int = cursor_stack.amount
	var cursor_can_equip: bool = true if cursor_stack.is_empty() else cursor_stack.item.can_equip(slot)

	# Case 1: Empty cursor
	if cursor.is_cursor_stack_empty():
		if slot_amount > 0 and slot_can_unequip:
			var take_amount := int(slot_amount / 2.0)
			cursor.set_click(ItemStack.new(slot_item, take_amount), slot_index)
			slot_stack.amount = slot_amount - take_amount
			slot.render_slot(slot_stack)

	# Case 2: Cursor loaded and slot empty
	elif slot_amount <= 0:
		if cursor_can_equip:
			inventory[slot_index] = ItemStack.new(cursor_item, 1)
			cursor_stack.amount = cursor_amount - 1
			slot.render_slot(inventory[slot_index])
			cursor_item.on_equip(slot)

	# Case 3: Cursor loaded and equal to slot
	elif cursor.is_equal_to(slot_stack):
		if slot_can_unequip and cursor_can_equip:
			var extra = slot_stack.add_amount_safe(1)
			if extra == 0:
				cursor_stack.amount = cursor_amount - 1
			else:
				cursor_stack.amount = extra
			slot.render_slot(slot_stack)

	# Case 4: Cursor loaded, but different from the slot
	else:
		if slot_can_unequip and cursor_can_equip:
			var temp: ItemStack = inventory[slot_index]
			temp.item.on_unequip(slot)
			inventory[slot_index] = cursor_stack
			cursor_item.on_equip(slot)
			cursor.set_click(temp, slot_index)
			slot.render_slot(inventory[slot_index])

	# If the cursor is empty, clear it.
	if cursor.is_cursor_stack_empty():
		cursor.clear_cursor()
