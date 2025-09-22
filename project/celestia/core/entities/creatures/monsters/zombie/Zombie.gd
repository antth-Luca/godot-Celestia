extends LivingEntity
class_name Zombie

var state_left_time: float

# GODOT
func _init() -> void:
	entity_data = EntityData.new(
		EntityData.FACTION_MASK.MONSTER,
		PropertyManager.create_manager({
			InitPropProviders.HEALTH: 80,
			InitPropProviders.ARMOR: 0,
			InitPropProviders.RESISTANCE: 0,
			InitPropProviders.DAMAGE_REDUCTION: 0,
			InitPropProviders.FORCE: 16,
			InitPropProviders.PENETRATION: 0,
			InitPropProviders.DEFENSE_REDUCTION: 0,
			InitPropProviders.CRITICAL_STRIKE: 0,
			InitPropProviders.LIFE_STEAL: 0.3,
			InitPropProviders.MOVE_SPEED: 20
		})
	)

# GETTERS AND SETTERS
# Source Entity
func get_source_entity() -> LivingEntity:
	return self

# HitData
func get_hit_data() -> HitData:
	return HitData.new(
		self,
		1,
		HitData.PRIMITIVE_TYPE.PHYSIC,
		HitData.SPECIALIZED_TYPE.NONE
	)

# SUPER
# Main
func die(attacker: LivingEntity) -> void:
	entity_data.is_dead = true
	ANIMATION.play('death')
	await ANIMATION.animation_finished

	var loot_box: LootBox = InitLootBoxes.ZOMBIE.get_registered()
	var item_stacks: Array[ItemStack] = loot_box.get_sorted_output(attacker)
	for stack in item_stacks:
		DroppedItemUtils.drop_item_entity_foot(stack, self)

	queue_free()
