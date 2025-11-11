extends BaseStructure
class_name Farmland

const READY_BALLON = preload('res://assets/celestia/interface/icons/ready_ballon.png')
const WATER_BALLON = preload('res://assets/celestia/interface/icons/water_ballon.png')

@onready var PLANT_TEXTURE: Sprite2D = $PlantTexture
@onready var BALLON_TEXTURE: Sprite2D = $BallonTexture
@onready var stage_timer: Timer = $StageTimer

var item_seed: BaseSeed
var current_stage: int:
	set(new_stage):
		current_stage = new_stage
		PLANT_TEXTURE.frame = current_stage
var is_growing: bool = false
var needs_water: bool = false:
	set(new_needs):
		needs_water = new_needs
		if needs_water:
			BALLON_TEXTURE.texture = WATER_BALLON
			BALLON_TEXTURE.visible = true
		else:
			BALLON_TEXTURE.visible = false

# GODOT
func _init() -> void:
	structure_data = StructureData.new(
		[
			PickaxeTool.get_static_comparable_name(),
			AxeTool.get_static_comparable_name(),
			SwordTool.get_static_comparable_name()
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
func _set_outline(state: bool) -> void:
	super._set_outline(state)
	PLANT_TEXTURE.material.set_shader_parameter('outline_enabled', state)


func on_interact(entity: LivingEntity) -> void:
	var hand_slot: BaseSlot = entity.inventory.get_hand()
	# Fertilizing
	if try_fertilize(hand_slot): return
	# Watering
	elif try_water(hand_slot): return
	# Seeding
	elif try_seed(hand_slot): return
	# Harvest
	try_harvest(entity)


func damage(final_dam: float, hit: HitData, hitbox_parent: Variant) -> void:
	if try_harvest(hit.attacker): return
	if hit.tool.get_comparable_name() == structure_data.compatible_tools.front():
		super.damage(final_dam, hit, hitbox_parent)

# MAIN
func is_ready_to_harvest() -> bool:
	if not item_seed: return false
	return not current_stage < item_seed.grow_stages - 1


func add_plant_texture(i_seed: BaseSeed) -> void:
	PLANT_TEXTURE.texture = load(Celestia.PLANT_STRUCT_SPRITE_PATH % i_seed.plant_location.get_splited())
	PLANT_TEXTURE.visible = true
	PLANT_TEXTURE.hframes = i_seed.grow_stages
	var y_pos: int = PLANT_TEXTURE.texture.get_height() * -1
	PLANT_TEXTURE.position.y = int(y_pos / 2.0)
	BALLON_TEXTURE.position.y = y_pos


func try_seed(hand_slot: BaseSlot) -> bool:
	var hand_stack: ItemStack = hand_slot.stack
	if item_seed or not hand_stack.item is BaseSeed: return false
	item_seed = hand_stack.item
	hand_stack.sub_amount(1, hand_slot)
	add_plant_texture(item_seed)
	current_stage = 0
	needs_water = true
	return true


func try_water(hand_slot: BaseSlot) -> bool:
	var hand_stack: ItemStack = hand_slot.stack
	if not needs_water or not hand_stack.item.id.get_string() == InitItems.WATER_BOWL.location.get_string(): return false
	hand_stack.sub_amount(1, hand_slot)
	hand_slot.player.inventory.add_item_to_backpack(ItemStack.new(InitItems.CERAMIC_BOWL.get_registered(), 1))
	needs_water = false
	stage_timer.start(item_seed.time_per_stage)
	return true


func try_fertilize(hand_slot: BaseSlot) -> bool:
	var hand_stack: ItemStack = hand_slot.stack
	if not item_seed or is_ready_to_harvest() or needs_water or not hand_stack.item is BaseFertilizer: return false
	hand_stack.sub_amount(1, hand_slot)
	var reduce: float = item_seed.time_per_stage * hand_stack.item.power
	stage_timer.start(max(stage_timer.time_left - reduce, .1))
	return true


func try_harvest(entity: LivingEntity) -> bool:
	if is_ready_to_harvest():
		for out in item_seed.get_crop(entity):
			DroppedItemUtils.drop_item_in_position(out, global_position)
	elif item_seed:
		DroppedItemUtils.drop_item_in_position(ItemStack.new(item_seed, 1), global_position)
	else:
		return false
	BALLON_TEXTURE.visible = false
	PLANT_TEXTURE.visible = false
	item_seed = null
	return true

# HANDLERS
func _on_stage_timer_timeout() -> void:
	current_stage += 1
	if is_ready_to_harvest():
		BALLON_TEXTURE.texture = READY_BALLON
		BALLON_TEXTURE.visible = true
		return
	needs_water = true
