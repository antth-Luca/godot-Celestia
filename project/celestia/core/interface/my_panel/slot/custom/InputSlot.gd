extends BaseSlot
class_name InputSlot

signal slot_item_added()
signal slot_item_removed()

func render_slot() -> void:
	super.render_slot()
	emit_signal('slot_item_added')


func clear_slot() -> void:
	super.clear_slot()
	emit_signal('slot_item_removed')
