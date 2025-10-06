extends Node


func spawn_structure_in_position(structure: BaseStructure, pos: Vector2) -> void:
	get_tree().current_scene.add_child(structure)
	structure.global_position = pos


func spawn_structure_entity_foot(structure: BaseStructure, entity: LivingEntity) -> void:
	var at_pos = entity.global_position  # TODO: Adicionar correção de pos para ter um offset.
	spawn_structure_in_position(structure, at_pos)
