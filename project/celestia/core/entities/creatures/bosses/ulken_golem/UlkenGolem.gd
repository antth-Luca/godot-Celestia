extends LivingEntity
class_name UlkenGolem

@onready var ARMS_ANIMATION: AnimationPlayer = $ArmsAnimation

var is_attacking: bool = false
var can_switch_arms_animation: bool = true
var targets: Array[Player]

# GODOT
func _init() -> void:
	entity_data = EntityData.new(
		EntityData.FACTION_MASK.MONSTER,
		PropertyManager.create_manager({
			InitPropProviders.ELETRIC_DAMAGE_MODIFIER: 1,
			InitPropProviders.MOBILITY_MODIFIER: 1,
			InitPropProviders.HEAL_MODIFIER: 1,
			InitPropProviders.HEALTH: 300,
			InitPropProviders.ARMOR: 5,
			InitPropProviders.RESISTANCE: 5,
			InitPropProviders.DAMAGE_REDUCTION: 0,
			InitPropProviders.FORCE: 12,
			InitPropProviders.PENETRATION: 0,
			InitPropProviders.DEFENSE_REDUCTION: 0,
			InitPropProviders.CRITICAL_STRIKE: 0,
			InitPropProviders.LIFE_STEAL: 0.3,
			InitPropProviders.MOVE_SPEED: 30
		})
	)


func _ready() -> void:
	ANIMATION.play_backwards('wake_up')
	entity_data.is_dead = true

# GETTERS AND SETTERS
# Source Entity
func get_source_entity() -> LivingEntity:
	return self

# HitData
func get_hit_data() -> HitData:
	return HitData.new(
		self,
		HitData.PRIMITIVE_TYPE.MAGIC,
		HitData.SPECIALIZED_TYPE.EXPLOSION,
		HitData.SOURCE.HIT,
	)

# Animation
func set_animation() -> void:
	if entity_data.is_dead: return
	var anim_body = 'walk'
	var anim_arms = 'walk'
	if is_attacking: anim_arms = 'attack'
	if ANIMATION.current_animation != anim_body:
		ANIMATION.play(anim_body)
	if can_switch_arms_animation and ARMS_ANIMATION.current_animation != anim_arms:
		ARMS_ANIMATION.play(anim_arms)

# HANDLERS
func _on_activate_area_body_entered(body) -> void:
	if body.is_in_group('player'):
		# TODO: Aciona a barra de vida de chefe!
		targets.append(body)
		if targets.size() == 1:
			ANIMATION.play('wake_up')
			await ANIMATION.animation_finished
			entity_data.is_dead = false
			var machine_state: StateMachine = get_node('MachineState')
			var fury_chase: FuryChaseState = machine_state.get_node('FuryChase')
			fury_chase.target = targets.front()
			machine_state.change_state_to_node(fury_chase)


func _on_activate_area_body_exited(body) -> void:
	if body.is_in_group('player'):
		# TODO: Desaciona a barra de vida de chefe!
		targets.remove_at(targets.find(body))
		if targets.is_empty():
			var machine_state: StateMachine = get_node('MachineState')
			machine_state.clear_state()
			entity_data.is_dead = true
			ANIMATION.play_backwards('wake_up')
