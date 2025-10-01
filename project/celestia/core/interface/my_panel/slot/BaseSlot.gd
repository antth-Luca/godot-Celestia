extends Button
class_name BaseSlot

signal slot_rendered(stack: ItemStack)
signal slot_cleaned()
signal slot_hovered(slot: BaseSlot)
signal slot_unhovered()

const Type: Dictionary =  {
	GENERIC = 'generic',
	HEAD = 'head',
	CHESTPLATE = 'chestplate',
	LEGS = 'legs',
	FEET = 'feet',
	RELIC = 'relic',
	AMMO = 'ammo',
	INPUT = 'input',
	FUEL = 'fuel',
	OUTPUT = 'output'
}

@export_enum(
	'generic',
	'head',
	'chestplate',
	'legs',
	'feet',
	'relic',
	'ammo',
	'input',
	'fuel',
	'output'
) var slot_type: String = Type.GENERIC

@onready var slotTypeSprite: Sprite2D = $SlotType
@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount
var cursor: PanelCursor  # Filled by #_ready()
var player: Player  # Filled by <parent>#fill_children() - From Inventory, Stats or Craft Tab
var stack: ItemStack:
	set(new_stack):
		if not new_stack: return
		stack = new_stack
		if new_stack.is_empty():
			clear_slot()
			return
		else:
			render_slot()
		


func _ready():
	var my_panel: MyPanel = get_my_panel()
	cursor = my_panel.get_cursor()
	var popup_tooltip: PopupTooltip = my_panel.get_popup_tooltip()
	connect('slot_hovered', Callable(popup_tooltip, '_handle_mouse_entered_on_slot'))
	connect('slot_unhovered', Callable(popup_tooltip, '_handle_mouse_exited_on_slot'))
	if slot_type != Type.GENERIC:
		slotTypeSprite.texture = load(Celestia.SLOT_TYPE_SPRITE_PATH % [Celestia.GAME_ID, slot_type])
	stack = ItemStack.EMPTY

# GETTERS AND SETTERS
func get_my_panel() -> MyPanel:
	return get_parent().get_parent().get_parent()

# HANDLERS
func render_slot() -> void:
	slotTypeSprite.visible = false
	itemSprite.texture = load(Celestia.ITEM_SPRITE_PATH % stack.item.id.get_splited())
	itemSprite.visible = true
	if stack.amount > 1:
		itemAmount.text = str(stack.amount)
		itemAmount.visible = true
	else:
		itemAmount.visible = false
	var slot_index: int = get_index()
	if slot_index == InventoryManager.MIN_SLOTS:
		if player: player.hand.ITEM_HAND_TEXTURE.texture = itemSprite.texture
	if slot_index in [0, 1, 2, 3]:
		emit_signal('slot_rendered', stack)


func clear_slot() -> void:
	slotTypeSprite.visible = true
	itemSprite.texture = null
	itemAmount.visible = false
	var slot_index: int = get_index()
	if slot_index == InventoryManager.MIN_SLOTS:
		if player: player.hand.ITEM_HAND_TEXTURE.texture = null
	if slot_index in [0, 1, 2, 3]:
		emit_signal('slot_cleaned')


func _on_mouse_entered():
	emit_signal('slot_hovered', self)


func _on_mouse_exited():
	emit_signal('slot_unhovered')

# SIGNALS
func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				_handle_left_click_on_slot()
			MOUSE_BUTTON_MIDDLE:
				_handle_middle_click_on_slot()
			MOUSE_BUTTON_RIGHT:
				_handle_right_click_on_slot()


func _handle_left_click_on_slot():
	var slot_stack: ItemStack = stack
	var slot_item: BaseItem = slot_stack.item
	var slot_can_unequip: bool = false if slot_stack.is_empty() else slot_item.can_unequip(self)

	var cursor_stack: ItemStack = cursor.stack
	var cursor_item: BaseItem = cursor_stack.item
	var cursor_can_equip: bool = true if cursor_stack.is_empty() else cursor_stack.item.can_equip(self)

	# Case 1: Empty cursor
	if cursor_stack.is_empty():
		if slot_can_unequip:
			cursor.stack = slot_stack
			stack = ItemStack.EMPTY
			slot_item.on_unequip(self, player)

	# Case 2: Cursor loaded and slot empty
	elif slot_stack.is_empty():
		if cursor_can_equip:
			stack = cursor_stack
			cursor.stack = ItemStack.EMPTY
			cursor_item.on_equip(self, player)

	# Case 3: Cursor loaded and equal to slot
	elif cursor_stack.is_equal_to(slot_stack):
		if slot_can_unequip and cursor_can_equip:
			var extra: int = slot_stack.add_amount_safe(cursor_stack.amount)
			if extra <= 0:
				cursor.stack = ItemStack.EMPTY
			else:
				cursor_stack.amount = extra
			render_slot()

	# Case 4: Cursor loaded, but different from the slot
	else:
		if slot_can_unequip and cursor_can_equip:
			var temp: ItemStack = stack
			temp.item.on_unequip(self, player)
			stack = cursor_stack
			cursor_item.on_equip(self, player)
			cursor.stack = temp


func _handle_middle_click_on_slot():
	var slot_stack: ItemStack = stack

	if slot_stack.amount > 0 and slot_stack.item.can_unequip(self):
		stack.item.on_unequip(self, player)
		stack = ItemStack.EMPTY
		DroppedItemUtils.drop_item_entity_foot(slot_stack, player)


func _handle_right_click_on_slot():
	var slot_stack: ItemStack = stack
	var slot_amount: int = slot_stack.amount
	var slot_item: BaseItem = slot_stack.item
	var slot_can_unequip: bool = false if slot_stack.is_empty() else slot_item.can_unequip(self)

	var cursor_stack: ItemStack = cursor.stack
	var cursor_item: BaseItem = cursor_stack.item
	var cursor_amount: int = cursor_stack.amount
	var cursor_can_equip: bool = true if cursor_stack.is_empty() else cursor_stack.item.can_equip(self)

	# Case 1: Empty cursor
	if cursor.stack.is_empty():
		if slot_can_unequip:
			var take_amount := int(slot_amount / 2.0)
			cursor.stack = ItemStack.new(slot_item, take_amount)
			slot_stack.amount = slot_amount - take_amount
			render_slot()

	# Case 2: Cursor loaded and slot empty
	elif slot_stack.is_empty():
		if cursor_can_equip:
			stack = ItemStack.new(cursor_item, 1)
			cursor_stack.amount = cursor_amount - 1
			cursor_item.on_equip(self, player)

	# Case 3: Cursor loaded and equal to slot
	elif cursor_stack.is_equal_to(slot_stack):
		if slot_can_unequip and cursor_can_equip:
			var extra = slot_stack.add_amount_safe(1)
			if extra == 0:
				cursor_stack.amount = cursor_amount - 1
			else:
				cursor_stack.amount = extra
			render_slot()

	# Case 4: Cursor loaded, but different from the slot
	else:
		if slot_can_unequip and cursor_can_equip:
			var temp: ItemStack = stack
			temp.item.on_unequip(self, player)
			stack = cursor_stack
			cursor_item.on_equip(self, player)
			cursor.setack = temp

	# If the cursor is empty, clear it.
	if cursor.stack.is_empty(): cursor.clear_cursor()
