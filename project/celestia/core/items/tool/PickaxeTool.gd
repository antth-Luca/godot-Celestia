extends BaseTool
class_name PickaxeTool

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
	return 'PickaxeTool'


func get_comparable_name() -> String:
	return PickaxeTool.get_static_comparable_name()

# Main
func copy(copy_obj: Variant = PickaxeTool.new()) -> Variant:
	return super.copy(copy_obj)


func interact(player: Player) -> void:
	StructuresUtils.spawn_structure_entity_foot(
		InitStructures.CAVE_HOLE.get_registered(),
		player
	)
	consume_durability(1, player.inventory.get_hand())
	set_cooldown(player)
