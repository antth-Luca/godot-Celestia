extends BaseSlot
class_name InputSlot

signal slot_item_added()
signal slot_item_removed()

# SUPER
# Handlers
func render_slot() -> void:
	super.render_slot()
	emit_signal('slot_item_added')


func clear_slot() -> void:
	super.clear_slot()
	emit_signal('slot_item_removed')

# Signals
func _handle_left_click_on_slot():
	if not get_parent().can_set_input: return
	super._handle_left_click_on_slot()


func _handle_middle_click_on_slot():
	if not get_parent().can_set_input: return
	super._handle_middle_click_on_slot()


func _handle_right_click_on_slot():
	if not get_parent().can_set_input: return
	super._handle_right_click_on_slot()
