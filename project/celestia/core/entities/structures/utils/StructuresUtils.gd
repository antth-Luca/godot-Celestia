extends Node


func spawn_structure_in_position(structure: BaseStructure, pos: Vector2) -> void:
	get_tree().current_scene.add_child(structure)
	structure.global_position = pos


func spawn_structure_entity_foot(structure: BaseStructure, entity: LivingEntity) -> void:
	var dir: Vector2
	if entity.direction != Vector2.ZERO:
		dir = entity.direction.normalized() * -1
	else:
		dir = Vector2(-1, 0) if entity.TEXTURE.flip_h else Vector2(1, 0)
	var at_pos: Vector2 = entity.global_position + dir * 20
	spawn_structure_in_position(structure, at_pos)
