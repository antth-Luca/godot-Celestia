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
		InitStructures.CAVE_HOLE.get_registered(),
		player
	)
	consome_durability(1, player.inventory.get_hand())
	set_cooldown(player)
