extends BaseSlot
class_name OutputSlot

const RESULT_COLOR := Color(Color.WHITE, 1)
const PREVIEW_COLOR := Color(Color.WHITE, .5)

# SUPER
# Handlers
func render_slot() -> void:
	super.render_slot()
	itemSprite.modulate = RESULT_COLOR
	itemAmount.modulate = RESULT_COLOR

# MAIN
func set_output_preview() -> void:
	itemSprite.modulate = PREVIEW_COLOR
	itemAmount.modulate = PREVIEW_COLOR
