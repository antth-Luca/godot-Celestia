extends BaseTool
class_name SwordTool

# GODOT
func _init() -> void:
	damage_factor = 1.2
	base_lifespan = .3
	anim_type = BaseItem.AnimType.USE
	hit_type = InitHits.SLASH
