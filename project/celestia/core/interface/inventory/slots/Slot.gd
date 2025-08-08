extends Button
class_name Slot

@export var _defined_slot_type: int

@onready var slotTypeSprite: Sprite2D = $SlotType
@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount


func _ready():
	if _defined_slot_type < 0 or _defined_slot_type > 6:
		push_error('Slot type selected invalid.')
	elif _defined_slot_type != 0:
		slotTypeSprite.texture = load('res://assets/%s/interface/inventory/slots/types/%s.png' % SlotTypes.get_splited_id(_defined_slot_type))

# GETTERS AND SETTERS
func get_slot_type() -> int:
	return _defined_slot_type


func set_slot_type(type_key: int) -> void:
	_defined_slot_type = type_key

# HANDLERS
func render_slot(item_slot: ItemStack) -> void:
	slotTypeSprite.visible = false
	itemSprite.texture = load('res://assets/%s/textures/items/%s.png' % item_slot.get_item().get_splited_id())
	itemSprite.visible = true
	if item_slot.get_amount() > 1:
		itemAmount.text = str(item_slot.get_amount())
		itemAmount.visible = true
	else:
		itemAmount.visible = false

	var slot_index: int = get_index()
	if slot_index > 42 and slot_index < 47:
		EventBus.client_inventory.emit_signal('some_pocket_slot_has_updated', self, item_slot)


func clear_slot() -> void:
	slotTypeSprite.visible = true
	itemSprite.visible = false
	itemAmount.visible = false


func _on_mouse_entered():
	EventBus.client_inventory.emit_signal('mouse_entered_slot', self)


func _on_mouse_exited():
	EventBus.client_inventory.emit_signal('mouse_exited_slot')

# SIGNALS
func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				EventBus.client_inventory.emit_signal('left_click_slot', self)
			MOUSE_BUTTON_MIDDLE:
				EventBus.client_inventory.emit_signal('middle_click_slot', self)
			MOUSE_BUTTON_RIGHT:
				EventBus.client_inventory.emit_signal('right_click_slot', self)
