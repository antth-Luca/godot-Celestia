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
	var target_pos: Vector2 = StructuresUtils.get_corrected_entity_foot(player)
	var dimension = player.get_dimension()
	if dimension is SurfaceDimension:
		if dimension.get_grass_in_tile(target_pos):
			StructuresUtils.spawn_structure_in_position(
				InitStructures.CAVE_HOLE.get_registered(),
				target_pos, dimension
			)
		elif dimension.get_sand_in_tile(target_pos):
			DroppedItemUtils.drop_item_in_position(
				ItemStack.new(InitItems.HANDFUL_OF_SAND.get_registered(), 1),
				target_pos, dimension
			)
	elif dimension is CaveDimension:
		if dimension.get_dust_in_tile(target_pos):
			StructuresUtils.spawn_structure_in_position(
				InitStructures.CAVE_HOLE.get_registered(),
				target_pos, dimension
			)
	else:
		return
	consume_durability(1, player.inventory.get_hand())
	set_cooldown(player)
