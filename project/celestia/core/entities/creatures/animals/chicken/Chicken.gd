extends LivingEntity
class_name Chicken

@onready var lay_timer = $LayTimer
@onready var state_machine = $StateMachine

var state_left_time: float
var drop_timer: Timer

# GODOT
func _init() -> void:
	entity_data = EntityData.new(
		EntityData.FACTION_MASK.ANIMAL,
		PropertyManager.create_manager({
			InitPropProviders.HEALTH: 30,
			InitPropProviders.ARMOR: 0,
			InitPropProviders.RESISTANCE: 0,
			InitPropProviders.DAMAGE_REDUCTION: 0,
			InitPropProviders.MOVE_SPEED: 25
		})
	)


func _ready() -> void:
	# Drops
	var drop_state: DropResourceState = get_node('StateMachine/DropResource')
	drop_state.loot_box = InitLootBoxes.CHICKEN_LAY.get_registered()
	lay_timer.start()

# SUPER
# Main
func die(attacker: LivingEntity) -> void:
	entity_data.is_dead = true
	ANIMATION.play('death')
	await ANIMATION.animation_finished

	var loot_box: LootBox = InitLootBoxes.CHICKEN_DEATH.get_registered()
	var item_stacks: Array[ItemStack] = loot_box.get_sorted_output(attacker)
	for stack in item_stacks:
		DroppedItemUtils.drop_item_entity_foot(stack, self)

	queue_free()

# MAIN
func lay_egg() -> void:
	state_machine.change_state_to_string('drop_resource')
