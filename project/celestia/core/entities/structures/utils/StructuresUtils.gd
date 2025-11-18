extends Node


func get_corrected_entity_foot(entity: LivingEntity) -> Vector2:
	var dir: Vector2
	if entity.direction != Vector2.ZERO:
		dir = entity.direction.normalized() * -1
	else:
		dir = Vector2(-1, 0) if entity.TEXTURE.flip_h else Vector2(1, 0)
	return entity.global_position + dir * 20


func spawn_structure_in_position(structure: BaseStructure, pos: Vector2) -> void:
	get_tree().current_scene.add_child(structure)
	structure.global_position = pos


func spawn_structure_entity_foot(structure: BaseStructure, entity: LivingEntity) -> void:
	spawn_structure_in_position(structure, get_corrected_entity_foot(entity))
