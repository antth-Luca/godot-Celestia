extends TextureRect
class_name InteractConfirm

const DRAG_ENABLED_COLOR := Color(Color.WHITE, 1)
const DRAG_DISABLED_COLOR := Color(Color.WHITE, .5)

var can_drag := false

# GODOT
func _ready() -> void:
	disable_interaction()

# MAIN
func enable_interaction():
	modulate = DRAG_ENABLED_COLOR
	can_drag = true


func disable_interaction():
	modulate = DRAG_DISABLED_COLOR
	can_drag = false

# Drag and Drop
func _get_drag_data(_at_pos: Vector2) -> Variant:
	if not can_drag: return null
	var preview := TextureRect.new()
	preview.texture = texture
	preview.scale *= 2.5
	set_drag_preview(preview)
	return ''
