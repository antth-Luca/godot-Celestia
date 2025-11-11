extends BaseStructure
class_name Farmland

@onready var PLANT_TEXTURE: Sprite2D = $PlantTexture
@onready var stage_timer: Timer = $StageTimer

var item_seed: BaseSeed
var current_stage: int:
	set(new_stage):
		current_stage = new_stage
		PLANT_TEXTURE.frame = current_stage
var is_growing: bool = false
var needs_water: bool = false

# GODOT
func _init() -> void:
	structure_data = StructureData.new(
		[
			AxeTool.get_static_comparable_name(),
			PickaxeTool.get_static_comparable_name(),
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
	# Watering
	if try_water(hand_slot): return
	# Seeding
	elif try_seed(hand_slot): return
	# Harvest
	try_harvest(hand_slot)


func damage(final_dam: float, hit: HitData, hitbox_parent: Variant) -> void:
	super.damage(final_dam, hit, hitbox_parent)


func destroy(attacker: LivingEntity) -> void:
	if item_seed:
		PLANT_TEXTURE.visible = false
		if current_stage < item_seed.grow_stages:
			DroppedItemUtils.drop_item_in_position(ItemStack.new(item_seed, 1), global_position)
		else:
			for out in item_seed.get_crop(attacker):
				DroppedItemUtils.drop_item_in_position(out, global_position)
		item_seed = null
	super.destroy(attacker)

# MAIN
func add_plant_texture(i_seed: BaseSeed) -> void:
	PLANT_TEXTURE.texture = load(Celestia.PLANT_STRUCT_SPRITE_PATH % i_seed.plant_location.get_splited())
	PLANT_TEXTURE.hframes = i_seed.grow_stages
	PLANT_TEXTURE.visible = true


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


func try_harvest(_hand_slot: BaseSlot) -> void: pass

# HANDLERS
func _on_stage_timer_timeout() -> void:
	current_stage += 1
	needs_water = true
