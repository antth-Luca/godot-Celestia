extends ColorRect
class_name PauseMenu

@onready var shader_material: ShaderMaterial = self.material

func open_menu() -> void:
	var open_tween: Tween = create_tween()
	open_tween.tween_property(shader_material, 'shader_parameter/lod', 1.0, 0.3)
	await open_tween.finished
	visible = false


func close_menu() -> void:
	visible = true
	var open_tween: Tween = create_tween()
	open_tween.tween_property(shader_material, 'shader_parameter/lod', 0, 0.3).from(1.0)
	await open_tween.finished
