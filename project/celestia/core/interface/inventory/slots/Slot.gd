extends Button
class_name Slot

@export var _slot_type: int

@onready var slotTypeSprite: Sprite2D = $SlotType
@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount


func _ready():
	if _slot_type < 0 or _slot_type > 6:
		push_error('Slot: Slot type selected invalid.')
	elif _slot_type != 0:
		slotTypeSprite.texture = load('res://assets/%s/interface/inventory/slots/types/%s.png' % SlotTypes.get_splited_id(_slot_type))

# GETTERS AND SETTERS
# Node
func get_inventory_tab():
	return get_parent().get_parent()

# Variables
func get_slot_type() -> int:
	return _slot_type


func set_slot_type(type_key: int) -> void:
	_slot_type = type_key

# HANDLERS
func render_slot(item_slot: ItemStack) -> void:
	slotTypeSprite.visible = false
	itemSprite.texture = load('res://assets/%s/textures/items/%s.png' % item_slot.get_item().get_id().get_splited())
	itemSprite.visible = true
	if item_slot.get_amount() > 1:
		itemAmount.text = str(item_slot.get_amount())
		itemAmount.visible = true
	else:
		itemAmount.visible = false

	var slot_index: int = get_index()
	if slot_index in [0, 1, 2, 3]:
		get_inventory_tab().get_inventory_panel().get_ui().get_hud().get_rotative_pocket()._synchronize_pseudo_slot(
			slot_index,
			item_slot
		)


func clear_slot() -> void:
	slotTypeSprite.visible = true
	itemSprite.visible = false
	itemAmount.visible = false

	var slot_index: int = get_index()
	if slot_index in [0, 1, 2, 3]:
		get_inventory_tab().get_inventory_panel().get_ui().get_hud().get_rotative_pocket()._synchronize_pseudo_slot(
			slot_index
		)


func _on_mouse_entered():
	get_inventory_tab().get_popup_tooltip()._handle_entered_mouse_on_slot(self)


func _on_mouse_exited():
	get_inventory_tab().get_popup_tooltip()._handle_exited_mouse_on_slot()

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
