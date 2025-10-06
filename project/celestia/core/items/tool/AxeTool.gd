extends BaseTool
class_name AxeTool

static var COMPARABLE_NAME = 'AxeTool'

# GODOT
func _init() -> void:
	damage_factor = .8
	base_lifespan = .2
	anim_type = BaseItem.AnimType.USE
	hit_type = InitHits.SLASH
