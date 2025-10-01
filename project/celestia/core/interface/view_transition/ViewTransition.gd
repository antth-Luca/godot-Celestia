extends ColorRect
class_name ViewTransition

@onready var shader_material: ShaderMaterial = self.material

# MAIN
func open_eyes() -> void:
	await get_tree().create_timer(.1).timeout
	var open_tween: Tween = create_tween()
	open_tween.tween_property(shader_material, 'shader_parameter/open_amount', 1.0, .8)
	await open_tween.finished
	visible = false


func close_eyes() -> void:
	visible = true
	var open_tween: Tween = create_tween()
	open_tween.tween_property(shader_material, 'shader_parameter/open_amount', 0, .8).from(1.0)
	await open_tween.finished
