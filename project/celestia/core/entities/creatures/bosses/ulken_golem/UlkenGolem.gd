extends LivingEntity
class_name UlkenGolem

@onready var ARMS_ANIMATION: AnimationPlayer = $ArmsAnimation

var is_dashing: bool = false
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
			InitPropProviders.LIFE_STEAL: 0,
			InitPropProviders.MOVE_SPEED: 30
		})
	)


func _ready() -> void:
	ANIMATION.play_backwards('wake_up')
	entity_data.is_dead = true

# SUPER
# Godot
func _physics_process(_delta: float) -> void:
	if entity_data.is_dead: return
	# Knockback
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	else:
		# Get the input direction and handle the movement/deceleration.
		var stats_move_speed = entity_data.stats.get_property(InitPropProviders.MOVE_SPEED).get_move_speed()
		if is_dashing: stats_move_speed *= 2.5
		if direction != Vector2.ZERO and not entity_data.is_stunned and not entity_data.is_rooted:
			velocity = direction * stats_move_speed
			flip_texture()
		else:
			velocity = velocity.move_toward(Vector2.ZERO, stats_move_speed)
	# Setting state and animation and continuing movement
	set_animation()
	move_and_slide()

# Main
func die(_attacker: LivingEntity) -> void:
	# Animation
	entity_data.is_dead = true
	ANIMATION.play('death')
	await ANIMATION.animation_finished
	# Drop
	# TODO: Adicionar drop.
	# World
	var world: World = get_tree().root.get_node('World')
	world.set_defeated_bosses(1)
	# Clear
	queue_free()

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

# 
func get_dashes_number() -> int:
	var hp_prop: HealthProperty = entity_data.stats.get_property(InitPropProviders.HEALTH)
	return 5 - int(((hp_prop.get_health() / hp_prop.get_max_health()) * 100.0) / 25.0)

# HANDLERS
func _on_activate_area_body_entered(body) -> void:
	if body.is_in_group('player'):
		# Boss HP bar
		var boss_hp_bar: BossHealthBar = body.get_ui().get_hud().get_boss_health_bar()
		var hp_prop: HealthProperty = entity_data.stats.get_property(InitPropProviders.HEALTH)
		hp_prop.connect('max_health_changed', Callable(boss_hp_bar, '_on_max_health_changed'))
		hp_prop.emit_signal('max_health_changed', hp_prop.get_max_health())
		hp_prop.connect('health_changed', Callable(boss_hp_bar, '_on_health_changed'))
		hp_prop.emit_signal('health_changed', hp_prop.get_health())
		boss_hp_bar.boss_name_label.text = tr('mob.%s.name' % id.path)
		boss_hp_bar.visible = true
		# Targets
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
		# Boss HP bar
		var boss_hp_bar: BossHealthBar = body.get_ui().get_hud().get_boss_health_bar()
		var hp_prop: HealthProperty = entity_data.stats.get_property(InitPropProviders.HEALTH)
		boss_hp_bar.visible = false
		hp_prop.disconnect('max_health_changed', Callable(boss_hp_bar, '_on_max_health_changed'))
		hp_prop.disconnect('health_changed', Callable(boss_hp_bar, '_on_health_changed'))
		# Targets
		if not entity_data.is_dead:
			targets.remove_at(targets.find(body))
			if targets.is_empty():
				var machine_state: StateMachine = get_node('MachineState')
				machine_state.clear_state()
				entity_data.is_dead = true
				ANIMATION.play_backwards('wake_up')
