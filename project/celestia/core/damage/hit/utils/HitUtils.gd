extends Node


func spawn_hit(source_entity: LivingEntity, hit_scene: DeferredHolder, source_tool: BaseTool) -> void:
	var hit: BaseHit = hit_scene.get_registered()
	hit.initialize(source_entity, source_tool)
	get_tree().current_scene.add_child(hit)
	hit.global_position = source_entity.global_position
