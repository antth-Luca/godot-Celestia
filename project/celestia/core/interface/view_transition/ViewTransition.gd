extends ColorRect
class_name ViewTransition

@onready var shader_material: ShaderMaterial = self.material

# MAIN
func open_eyes() -> void:
	var open_tween: Tween = create_tween()
	open_tween.tween_property(shader_material, 'shader_parameter/open_amount', 1.0, 0.5)
	await open_tween.finished
	visible = false


func close_eyes() -> void:
	visible = true
	var open_tween: Tween = create_tween()
	open_tween.tween_property(shader_material, 'shader_parameter/open_amount', 0, 0.5).from(1.0)
	await open_tween.finished
