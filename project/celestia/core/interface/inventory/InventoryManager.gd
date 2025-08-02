extends Control

@onready var slots_group = $SlotsGroup
@onready var popup_tooltip = $PopupTooltip

var inventory = []
var stack_in_cursor: ItemStack
var cursor_click_origin_slot: int
var sprite_to_cursor: Sprite2D = null


func _ready() -> void:
	clear_all_inventory()


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
		if slot.amount < slot.item.max_stack:
			return false
	return true


func get_stackable_index(item_id: String) -> int:
	for index in range(12, 42):  # Slots for backpack
		var invent_stack: ItemStack = inventory[index]
		if invent_stack.item_id == item_id and invent_stack.item.max_stack > 1:
			return index
	return -1


func drop_item_in_position(stack: ItemStack, pos: Vector2):
	# Drops an item in a specific position
	var dropped_item = preload("res://core/items/DroppedItem.tscn")
	var drop = dropped_item.instantiate()
	drop.initialize(stack)
	get_tree().root.add_child(drop)
	drop.global_position = pos


func drop_item_players_foot(stack: ItemStack):
	# Drops an item at the player's feet
	var player = get_parent().get_parent()
	var at_pos = player.global_position
	drop_item_in_position(stack, at_pos)


func add_item_to_bp_new_slot(stack: ItemStack):
	for index in range(12, 42):  # Slots for backpack
		if inventory[index].amount == 0:
			inventory[index] = stack
			slots_group.get_child(index).render_slot(inventory[index])
			return
	drop_item_players_foot(stack)


func add_item_to_backpack(stack: ItemStack) -> void:
	# Adds an item to the inventory, stacking, creating or ignoring it
	var remaining_amount = 0
	var stackable_index = get_stackable_index(stack.item_id)
	if not stackable_index < 0:  # Or: >= 0
		remaining_amount = inventory[stackable_index].add_amount_safe(stack.amount)
		slots_group.get_child(stackable_index).render_slot(inventory[stackable_index])
	else:
		remaining_amount = stack.amount
	# As long as there is an remaining amount, try adding
	while remaining_amount > 0:
		var item_max_stack: int = stack.item.max_stack
		if remaining_amount <= item_max_stack:
			add_item_to_bp_new_slot(ItemStack.new(
				stack.item_id,
				remaining_amount
			))
			return
		else:
			add_item_to_bp_new_slot(ItemStack.new(
				stack.item_id,
				item_max_stack
			))
			remaining_amount -= item_max_stack
