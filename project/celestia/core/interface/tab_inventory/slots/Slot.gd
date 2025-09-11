extends Button
class_name Slot

signal slot_rendered(stack: ItemStack)
signal slot_cleaned()
signal slot_hovered(slot: Slot)
signal slot_unhovered()

const Type: Dictionary =  {
	GENERIC = 'generic',
	HEAD = 'head',
	CHESTPLATE = 'chestplate',
	LEGS = 'legs',
	FEET = 'feet',
	RELIC = 'relic',
	AMMO = 'ammo'
}

@export_enum(
	'generic',
	'head',
	'chestplate',
	'legs',
	'feet',
	'relic',
	'ammo'
) var slot_type: String = Type.GENERIC

@onready var slotTypeSprite: Sprite2D = $SlotType
@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount


func _ready():
	if slot_type != Type.GENERIC:
		slotTypeSprite.texture = load(Celestia.SLOT_TYPE_SPRITE_PATH % [Celestia.GAME_ID, slot_type])

# GETTERS AND SETTERS
# Node
func get_inventory_tab() -> InventoryManager:
	return get_parent().get_parent()

# HANDLERS
func render_slot(slot_stack: ItemStack = ItemStack.EMPTY) -> void:
	var player: Player = get_inventory_tab().player
	if slot_stack.is_empty():
		slotTypeSprite.visible = true
		itemSprite.visible = false
		itemAmount.visible = false
		var slot_index: int = get_index()
		if player and slot_index == InventoryManager.MIN_SLOTS:
			player.hand.ITEM_HAND_TEXTURE.texture = null
		if slot_index in [0, 1, 2, 3]:
			emit_signal('slot_cleaned')
	else:
		slotTypeSprite.visible = false
		itemSprite.texture = load(Celestia.ITEM_SPRITE_PATH % slot_stack.item.id.get_splited())
		itemSprite.visible = true
		if slot_stack.amount > 1:
			itemAmount.text = str(slot_stack.amount)
			itemAmount.visible = true
		else:
			itemAmount.visible = false
		var slot_index: int = get_index()
		if slot_index == InventoryManager.MIN_SLOTS:
			player.hand.ITEM_HAND_TEXTURE.texture = itemSprite.texture
		if slot_index in [0, 1, 2, 3]:
			emit_signal('slot_rendered', slot_stack)


func _on_mouse_entered():
	emit_signal('slot_hovered', self)


func _on_mouse_exited():
	emit_signal('slot_unhovered')

# SIGNALS
func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				get_inventory_tab()._handle_left_click_on_slot(self)
			MOUSE_BUTTON_MIDDLE:
				get_inventory_tab()._handle_middle_click_on_slot(self)
			MOUSE_BUTTON_RIGHT:
				get_inventory_tab()._handle_right_click_on_slot(self)
