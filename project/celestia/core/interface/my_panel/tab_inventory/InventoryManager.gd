extends Control
class_name InventoryManager

const MIN_SLOTS: int = 0
const TOTAL_SLOTS: int = 46
const POCKET_SLOTS: Array[int] = [ 0, 1, 2, 3 ]
const BACKPACK_SLOTS: Array[int] = [ 4, 33 ]
const ARMOR_SLOTS: Dictionary[String, int] = {
	BaseSlot.Type.HEAD: 34,
	BaseSlot.Type.CHESTPLATE: 35,
	BaseSlot.Type.LEGS: 36,
	BaseSlot.Type.FEET: 37,
}
const RELIC_SLOTS: Array[int] = [ 38, 39, 40, 41, 42, 43 ]
const AMMO_SLOTS: Array[int] = [ 44, 45 ]

@onready var circle_sprite = $CircleSprite

var player: Player  # Filled by Player#_ready()
var inventory: Array[BaseSlot]  # Filled by #_ready()

# GODOT
func _ready() -> void:
	for slot: InventSlot in $SlotsGroup.get_children():
		inventory.append(slot)
		slot.parent_inventory = self
	get_inventory_panel().get_ui().connect('ui_rotate_pressed', Callable(self, '_on_ui_rotate_pressed'))


# GETTERS AND SETTERS
# Nodes
func get_inventory_panel() -> MyPanel:
	return get_parent()


func get_slot(slot_index: int) -> BaseSlot:
	return get_node('SlotsGroup').get_child(slot_index)


func get_popup_tooltip() -> PopupTooltip:
	return get_node('PopupTooltip')

# Inventory
func get_hand() -> BaseSlot:
	return inventory[POCKET_SLOTS.front()]


func get_pocket() -> Array[BaseSlot]:
	return inventory.slice(
		POCKET_SLOTS.front(),
		POCKET_SLOTS.back() + 1
	)


func get_backpack() -> Array[BaseSlot]:
	return inventory.slice(
		BACKPACK_SLOTS.front(),
		BACKPACK_SLOTS.back() + 1
	)


func get_armor(slot_type: String = '') -> Array[BaseSlot]:
	if !slot_type in BaseSlot.Type:
		return inventory.slice(
			ARMOR_SLOTS[BaseSlot.Type.HEAD],
			ARMOR_SLOTS[BaseSlot.Type.FEET] + 1
		)
	var index: int
	match slot_type:
		BaseSlot.Type.HEAD: index = ARMOR_SLOTS[BaseSlot.Type.HEAD]
		BaseSlot.Type.CHESTPLATE: index = ARMOR_SLOTS[BaseSlot.Type.CHESTPLATE]
		BaseSlot.Type.LEGS: index = ARMOR_SLOTS[BaseSlot.Type.LEGS]
		BaseSlot.Type.FEET: index = ARMOR_SLOTS[BaseSlot.Type.FEET]
	return inventory.slice(index, index + 1)


func get_relics() -> Array[BaseSlot]:
	return inventory.slice(
		RELIC_SLOTS.front(),
		RELIC_SLOTS.back() + 1
	)


func get_ammo_available() -> Array[BaseSlot]:
	return inventory.slice(
		AMMO_SLOTS.front(),
		AMMO_SLOTS.back() + 1
	)

# MAIN
func update_all_inventory() -> void:
	# Updates EACH of the slots in your inventory by emptying or rendering them
	for index in range(TOTAL_SLOTS):
		inventory[index].render_slot()


func clear_all_inventory() -> void:
	for index in range(TOTAL_SLOTS):
		inventory[index].stack = ItemStack.EMPTY

# Visibility
func switch_visible_top_inventory(to_bool: bool) -> void:
	# Circle
	circle_sprite.visible = to_bool
	# Armor + Relic + Ammo
	for index in range(ARMOR_SLOTS[BaseSlot.Type.HEAD], AMMO_SLOTS.back() + 1):
		inventory[index].visible = to_bool


func switch_visible_down_inventory(to_bool: bool) -> void:
	# Backpack + Pocket
	for index in range(POCKET_SLOTS.front(), BACKPACK_SLOTS.back() + 1):
		inventory[index].visible = to_bool


func switch_visible_all_inventory(to_bool: bool) -> void:
	switch_visible_top_inventory(to_bool)
	switch_visible_down_inventory(to_bool)


func get_stackable_index(item_id: ResourceLocation) -> int:
	for index in range(BACKPACK_SLOTS.back()):  # Slots for backpack
		var slot: BaseSlot = inventory[index]
		if slot.stack.is_empty(): return index
		if slot.stack.item.id == item_id and slot.stack.amount < slot.stack.item.max_stack:
			return index
	return -1


func add_item_to_bp_new_slot(add_stack: ItemStack) -> void:
	for index in range(BACKPACK_SLOTS.back()):  # Slots for backpack
		if inventory[index].stack.is_empty():
			inventory[index].stack = add_stack
			return
	DroppedItemUtils.drop_item_entity_foot(add_stack, player)


func add_item_to_backpack(add_stack: ItemStack) -> void:
	# Adds an item to the inventory, stacking, creating or ignoring it
	var stackable_index = get_stackable_index(add_stack.item.id)
	# There is no valid index...
	if stackable_index == -1: DroppedItemUtils.drop_item_entity_foot(add_stack, player)
	# ...Index is valid and slot is empty...
	if inventory[stackable_index].stack.is_empty():
		inventory[stackable_index].stack = add_stack
		return
	# ...BaseSlot is not empty, resources need to be added.
	var remaining_amount = inventory[stackable_index].stack.add_amount_safe(add_stack.amount)
	inventory[stackable_index].render_slot()
	# As long as there is an remaining amount, try adding
	while remaining_amount > 0:
		if remaining_amount <= add_stack.item.max_stack:
			add_item_to_bp_new_slot(ItemStack.new(
				add_stack.item,
				remaining_amount
			))
			return
		else:
			add_item_to_bp_new_slot(ItemStack.new(
				add_stack.item,
				add_stack.item.max_stack
			))
			remaining_amount -= add_stack.item.max_stack

# HANDLERS
func _on_ui_rotate_pressed() -> void:
	# Slots
	var last: ItemStack = inventory[POCKET_SLOTS.back()].stack
	for c in range(POCKET_SLOTS.back(), 0, -1):
		inventory[c].stack = inventory[c - 1].stack
	inventory[0].stack = last
