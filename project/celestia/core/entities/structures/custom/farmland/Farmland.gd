extends BaseStructure
class_name Farmland

@onready var PLANT_TEXTURE: Sprite2D = $PlantTexture
@onready var stage_timer: Timer = $StageTimer

var seed: BaseSeed
var current_stage: int
var is_growing: bool = false
var needs_water: bool = false

# GODOT
func _init() -> void:
	structure_data = StructureData.new(
		[
			PickaxeTool.get_static_comparable_name()
		],
		[
			InitMaterials.STONE.get_registered()
		],
		PropertyManager.create_manager({
			InitPropProviders.HEALTH: 2
		})
	)

# SUPER
# Main
func add_highlight() -> void:
	TEXTURE.material.set_shader_parameter('outline_enabled', true)
	PLANT_TEXTURE.material.set_shader_parameter('outline_enabled', true)


func remove_highlight() -> void:
	TEXTURE.material.set_shader_parameter('outline_enabled', false)
	PLANT_TEXTURE.material.set_shader_parameter('outline_enabled', false)

# MAIN
func on_interact(_entity: LivingEntity) -> void: pass


func destroy(attacker: LivingEntity) -> void:
	if seed:
		PLANT_TEXTURE.visible = false
		if current_stage < seed.grow_stages:
			DroppedItemUtils.drop_item_in_position(ItemStack.new(seed, 1), global_position)
		else:
			for out in seed.get_crop(attacker):
				DroppedItemUtils.drop_item_in_position(out, global_position)
		seed = null
	super.destroy(attacker)
