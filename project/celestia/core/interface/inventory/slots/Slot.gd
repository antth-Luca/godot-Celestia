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
		slotTypeSprite.texture = load('res://assets/%s/interface/inventory/slots/types/%s.png' % [Celestia.GAME_ID, slot_type])

# GETTERS AND SETTERS
# Node
func get_inventory_tab():
	return get_parent().get_parent()

# HANDLERS
func render_slot(slot_stack: ItemStack) -> void:
	slotTypeSprite.visible = false
	itemSprite.texture = load('res://assets/%s/textures/items/%s.png' % slot_stack.item.id.get_splited())
	itemSprite.visible = true
	if slot_stack.amount > 1:
		itemAmount.text = str(slot_stack.amount)
		itemAmount.visible = true
	else:
		itemAmount.visible = false

	var slot_index: int = get_index()
	if slot_index in [0, 1, 2, 3]:
		emit_signal('slot_rendered', slot_stack)


func clear_slot() -> void:
	slotTypeSprite.visible = true
	itemSprite.visible = false
	itemAmount.visible = false

	var slot_index: int = get_index()
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
				get_inventory_tab()._handle_left_click_on_slot(self)
			MOUSE_BUTTON_MIDDLE:
				get_inventory_tab()._handle_middle_click_on_slot(self)
			MOUSE_BUTTON_RIGHT:
				get_inventory_tab()._handle_right_click_on_slot(self)
