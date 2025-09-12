extends Node


func spawn_hit(source_entity: LivingEntity, hit_scene: PackedScene, calc_use_speed: float) -> void:
	var hit: BaseHit = hit_scene.instantiate()
	hit.initialize(source_entity, calc_use_speed)
	hit.global_position = source_entity.global_position
	get_tree().root.add_child(hit)
