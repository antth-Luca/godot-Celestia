extends BaseSlot
class_name OutputSlot

signal slot_item_removed()

const RESULT_COLOR := Color(Color.WHITE, 1)
const PREVIEW_COLOR := Color(Color.WHITE, .5)

var can_get_output := false

# SUPER
# Handlers
func render_slot() -> void:
	super.render_slot()


func clear_slot() -> void:
	super.clear_slot()
	emit_signal('slot_item_removed')

# Signals
func _handle_left_click_on_slot():
	if not can_get_output: return
	super._handle_left_click_on_slot()


func _handle_middle_click_on_slot():
	if not can_get_output: return
	super._handle_middle_click_on_slot()


func _handle_right_click_on_slot():
	if not can_get_output: return
	super._handle_right_click_on_slot()

# MAIN
func set_preview() -> void:
	can_get_output = false
	itemSprite.modulate = PREVIEW_COLOR
	itemAmount.modulate = PREVIEW_COLOR


func set_result() -> void:
	can_get_output = true
	itemSprite.modulate = RESULT_COLOR
	itemAmount.modulate = RESULT_COLOR

# Drag and Drop
func _can_drop_data(_at_position, _data) -> bool:
	return !stack.is_empty()


func _drop_data(_at_position, _data) -> void:
	set_result()
