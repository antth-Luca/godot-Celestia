extends Node


func spawn_hit(source_entity: LivingEntity, hit_scene: PackedScene, range_factor: float, damage_factor: float) -> void:
	var hit: BaseHit = hit_scene.instantiate()
	hit.initialize(source_entity, range_factor, damage_factor)
	hit.global_position = source_entity.global_position
	get_tree().root.add_child(hit)
