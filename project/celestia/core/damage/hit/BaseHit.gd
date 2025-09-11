extends Node
class_name BaseHit

var source_entity: LivingEntity

# MAIN
func initialize(source_entity_param: LivingEntity) -> void:
	source_entity = source_entity_param

# GETTERS AND SETTERS
# Entity
func get_source_entity() -> LivingEntity:
	return source_entity

# HitData
func get_hit_data() -> HitData:
	return null
