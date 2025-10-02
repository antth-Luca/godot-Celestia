extends BaseSlot
class_name OutputSlot

signal slot_item_added()
signal slot_item_removed()

const RESULT_COLOR := Color(Color.WHITE, 1)
const PREVIEW_COLOR := Color(Color.WHITE, .5)

# SUPER
# Handlers
func render_slot() -> void:
	super.render_slot()
	itemSprite.modulate = RESULT_COLOR
	itemAmount.modulate = RESULT_COLOR
	emit_signal('slot_item_added')

# MAIN
func set_output_preview() -> void:
	itemSprite.modulate = PREVIEW_COLOR
	itemAmount.modulate = PREVIEW_COLOR
	emit_signal('slot_item_removed')
