extends BaseTool
class_name SwordTool

static var COMPARABLE_NAME = 'SwordTool'

# SUPER
# Godot
func _init() -> void:
	damage_factor = 1.2
	base_lifespan = .3
	anim_type = BaseItem.AnimType.USE
	hit_type = InitHits.SLASH

# Getters and Setters
static func get_static_comparable_name() -> String:
	return 'SwordTool'


func get_comparable_name() -> String:
	return SwordTool.get_static_comparable_name()
