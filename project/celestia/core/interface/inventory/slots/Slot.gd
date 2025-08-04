extends Button

const slot_types = [
	'generic',
	'head',
	'chestplate',
	'legs',
	'feet',
	'relic',
	'ammo'
]

@export var defined_slot_type: int

@onready var slotTypeSprite: Sprite2D = $SlotType
@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount


func _ready():
	if defined_slot_type < 0 or defined_slot_type > 6:
		push_error('Slot type selected invalid.')
	elif defined_slot_type != 0:
		slotTypeSprite.texture = load('res://assets/celestia/interface/inventory/slots/types/%s.png' % [slot_types[defined_slot_type]])


func render_slot(item_slot: ItemStack) -> void:
	slotTypeSprite.visible = false
	itemSprite.texture = load('res://assets/%s/textures/items/%s.png' % item_slot.get_item().get_splited_id())
	itemSprite.visible = true
	if item_slot.get_amount() > 1:
		itemAmount.text = str(item_slot.get_amount())
		itemAmount.visible = true
	else:
		itemAmount.visible = false


func clear_slot() -> void:
	slotTypeSprite.visible = true
	itemSprite.visible = false
	itemAmount.visible = false


func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				EventBus.client_inventory.emit_signal('left_click_slot', self)
			MOUSE_BUTTON_MIDDLE:
				EventBus.client_inventory.emit_signal('middle_click_slot', self)
			MOUSE_BUTTON_RIGHT:
				EventBus.client_inventory.emit_signal('right_click_slot', self)


func _on_mouse_entered():
	EventBus.client_inventory.emit_signal('mouse_entered_slot', self)


func _on_mouse_exited():
	EventBus.client_inventory.emit_signal('mouse_exited_slot')
