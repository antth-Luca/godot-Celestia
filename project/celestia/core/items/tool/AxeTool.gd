extends BaseTool
class_name AxeTool

# SUPER
# Godot
func _init() -> void:
	super._init()
	damage_factor = .8
	base_lifespan = .2
	anim_type = BaseItem.AnimType.USE
	hit_type = InitHits.SLASH

# Getters and Setters
static func get_static_comparable_name() -> String:
	return 'AxeTool'


func get_comparable_name() -> String:
	return AxeTool.get_static_comparable_name()
