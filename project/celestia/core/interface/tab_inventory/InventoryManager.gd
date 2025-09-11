extends Control
class_name InventoryManager

const MIN_SLOTS: int = 0
const TOTAL_SLOTS: int = 46
const POCKET_SLOTS: Array[int] = [ 0, 1, 2, 3 ]
const BACKPACK_SLOTS: Array[int] = [ 4, 33 ]
const ARMOR_SLOTS: Dictionary[String, int] = {
	Slot.Type.HEAD: 34,
	Slot.Type.CHESTPLATE: 35,
	Slot.Type.LEGS: 36,
	Slot.Type.FEET: 37,
}
const RELIC_SLOTS: Array[int] = [ 38, 39, 40, 41, 42, 43 ]
const AMMO_SLOTS: Array[int] = [ 44, 45 ]

@onready var slots_group := $SlotsGroup
@onready var popup_tooltip: PopupTooltip = $PopupTooltip

var player: Player  # Filled by Player#_ready()

var cursor := CursorManager.new(self)
var inventory: Array[ItemStack] = []
var selected: int = 0

# GODOT
func _ready() -> void:
	clear_all_inventory()
	for slot in slots_group.get_children():
		slot.connect('slot_hovered', Callable(popup_tooltip, '_handle_mouse_entered_on_slot'))
		slot.connect('slot_unhovered', Callable(popup_tooltip, '_handle_mouse_exited_on_slot'))
	get_inventory_panel().get_ui().connect('ui_rotate_pressed', Callable(self, '_on_ui_rotate_pressed'))


func _input(event):
	if event is InputEventMouseMotion and not cursor.cursor_stack.is_empty():
		cursor.update_cursor_sprite_position(get_global_mouse_position())

# GETTERS AND SETTERS
# Nodes
func get_inventory_panel() -> MyPanel:
	return get_parent()


func get_slot(slot_index: int) -> Slot:
	return get_node('SlotsGroup').get_child(slot_index)


func get_popup_tooltip() -> PopupTooltip:
	return get_node('PopupTooltip')

# Inventory
func get_hand() -> ItemStack:
	return inventory[selected]


func get_pocket() -> Array[ItemStack]:
	return inventory.slice(
		POCKET_SLOTS.front(),
		POCKET_SLOTS.back() + 1
	)


func get_backpack() -> Array[ItemStack]:
	return inventory.slice(
		BACKPACK_SLOTS.front(),
		BACKPACK_SLOTS.back() + 1
	)


func get_armor(slot_type: String = '') -> Array[ItemStack]:
	if !slot_type in Slot.Type:
		return inventory.slice(
			ARMOR_SLOTS[Slot.Type.HEAD],
			ARMOR_SLOTS[Slot.Type.FEET] + 1
		)
	var index: int
	match slot_type:
		Slot.Type.HEAD: index = ARMOR_SLOTS[Slot.Type.HEAD]
		Slot.Type.CHESTPLATE: index = ARMOR_SLOTS[Slot.Type.CHESTPLATE]
		Slot.Type.LEGS: index = ARMOR_SLOTS[Slot.Type.LEGS]
		Slot.Type.FEET: index = ARMOR_SLOTS[Slot.Type.FEET]
	return inventory.slice(index, index + 1)


func get_relics() -> Array[ItemStack]:
	return inventory.slice(
		RELIC_SLOTS.front(),
		RELIC_SLOTS.back() + 1
	)


func get_ammo_available() -> Array[ItemStack]:
	return inventory.slice(
		AMMO_SLOTS.front(),
		AMMO_SLOTS.back() + 1
	)

# MAIN
func update_all_inventory() -> void:
	# Updates EACH of the slots in your inventory by emptying or rendering them
	for index in range(TOTAL_SLOTS):
		var slot = slots_group.get_child(index)
		slot.render_slot(inventory[index])


func clear_all_inventory() -> void:
	inventory.resize(TOTAL_SLOTS)
	inventory.fill(ItemStack.EMPTY)
	update_all_inventory()


func get_stackable_index(item_id: ResourceLocation) -> int:
	for index in range(BACKPACK_SLOTS.back()):  # Slots for backpack
		var invent_stack: ItemStack = inventory[index]
		if invent_stack.is_empty():
			return index
		else:
			var invent_item: BaseItem = invent_stack.item
			if invent_item.id == item_id and invent_stack.amount < invent_item.max_stack:
				return index
	return -1


func add_item_to_bp_new_slot(stack: ItemStack) -> void:
	for index in range(BACKPACK_SLOTS.back()):  # Slots for backpack
		if inventory[index].is_empty():
			inventory[index] = stack
			slots_group.get_child(index).render_slot(inventory[index])
			return
	DroppedItemUtils.drop_item_entity_foot(stack, player)


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
func _on_ui_rotate_pressed() -> void:
	selected += 1
	if selected > POCKET_SLOTS.back(): selected = POCKET_SLOTS.front()
	# Slots
	for c in range(POCKET_SLOTS.back() + 1):
		var slot: Slot = get_slot(c)
		slot.render_slot(inventory[c - selected])


func _on_inventory_closed() -> void:
	if not cursor.cursor_stack.is_empty():
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
	if cursor.cursor_stack.is_empty():
		if slot_amount > 0 and slot_can_unequip:
			cursor.set_click(slot_stack, slot_index)
			inventory[slot_index] = ItemStack.EMPTY
			slot.render_slot()
			slot_item.on_unequip(slot, player)

	# Case 2: Cursor loaded and slot empty
	elif slot_amount <= 0:
		if cursor_can_equip:
			inventory[slot_index] = cursor_stack
			cursor.clear_cursor()
			slot.render_slot(cursor_stack)
			cursor_item.on_equip(slot, player)

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
			temp.item.on_unequip(slot, player)
			inventory[slot_index] = cursor_stack
			cursor_item.on_equip(slot, player)
			cursor.set_click(temp, slot_index)
			slot.render_slot(cursor_stack)


func _handle_middle_click_on_slot(slot: Slot):
	var slot_index: int = slot.get_index()
	var slot_stack: ItemStack = inventory[slot_index]

	if slot_stack.amount > 0 and slot_stack.item.can_unequip(slot):
		inventory[slot_index].item.on_unequip(slot, player)
		inventory[slot_index] = ItemStack.EMPTY
		DroppedItemUtils.drop_item_entity_foot(slot_stack, player)
		slot.render_slot()


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
	if cursor.cursor_stack.is_empty():
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
			cursor_item.on_equip(slot, player)

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
			temp.item.on_unequip(slot, player)
			inventory[slot_index] = cursor_stack
			cursor_item.on_equip(slot, player)
			cursor.set_click(temp, slot_index)
			slot.render_slot(inventory[slot_index])

	# If the cursor is empty, clear it.
	if cursor.cursor_stack.is_empty():
		cursor.clear_cursor()
