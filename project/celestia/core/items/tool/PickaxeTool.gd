extends BaseTool
class_name PickaxeTool

static var COMPARABLE_NAME = 'PickaxeTool'

# GODOT
func _init() -> void:
	damage_factor = .8
	base_lifespan = .2
	anim_type = BaseItem.AnimType.USE
	hit_type = InitHits.SLASH

# SUPER
func interact(player: Player) -> void:
	StructuresUtils.spawn_structure_entity_foot(
		InitStructures.STONE_FURNACE.get_registered(),
		player
	)
