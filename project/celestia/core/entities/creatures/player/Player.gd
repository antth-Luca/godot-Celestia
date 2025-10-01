extends LivingEntity
class_name Player

const WALKING_HUNGRY: float = .01
const USE_HUNGRY: float = .3
const ROLL_HUNGRY: float = .8
const HURT_HUNGRY: float = .8

@onready var light_point = $LightPoint

var ESSENCE_COUNTER: int = 3
var PASSIVE_REGEN_VALUES: Array[float]

var inventory: InventoryManager
var hand: PlayerHand
var is_sleeping: bool = false

# GODOT
func _init() -> void:
	entity_data = EntityData.new(
		EntityData.FACTION_MASK.PLAYER,
		PropertyManager.create_manager({
			InitPropProviders.SURVIVOR_LEVEL: 1,
			InitPropProviders.HEALTH: 100,
			InitPropProviders.ARMOR: 0,
			InitPropProviders.RESISTANCE: 0,
			InitPropProviders.DAMAGE_REDUCTION: 0,
			InitPropProviders.FORCE: 8,
			InitPropProviders.PENETRATION: 0,
			InitPropProviders.DEFENSE_REDUCTION: 0,
			InitPropProviders.CRITICAL_STRIKE: 0,
			InitPropProviders.LIFE_STEAL: 0,
			InitPropProviders.MANA: 50,
			InitPropProviders.RANGE: 1,
			InitPropProviders.USE_SPEED: 1,
			InitPropProviders.MOVE_SPEED: 80,
			InitPropProviders.COOLDOWN_REDUCTION: 0,
			InitPropProviders.HUNGRY: 50,
			InitPropProviders.LUCK: 0
		})
	)


func _ready():
	# Shader
	TEXTURE.material.set_shader_parameter('blink_color', hurt_color)
	# Survivor level signal
	entity_data.stats.get_property(InitPropProviders.SURVIVOR_LEVEL).connect('level_up', Callable(self, '_on_surv_level_up'))
	# Passive regeneration values
	PASSIVE_REGEN_VALUES = [0, 0, 0]
	# World UI
	var ui = get_ui()
	ui.player = self
	ui.essence_vessel.set_max_essence(ESSENCE_COUNTER)
	ui.essence_vessel.set_essence(ESSENCE_COUNTER)
	# Stats bar signals
	var stats_bar = ui.get_hud().get_stats_bar()
	var health_prop: HealthProperty = entity_data.stats.get_property(InitPropProviders.HEALTH)
	health_prop.connect('max_health_changed', Callable(stats_bar, '_on_max_health_changed'))
	health_prop.emit_signal('max_health_changed', health_prop.get_max_health())
	health_prop.connect('health_changed', Callable(stats_bar, '_on_health_changed'))
	health_prop.emit_signal('health_changed', health_prop.get_health())
	var mana_prop: ManaProperty = entity_data.stats.get_property(InitPropProviders.MANA)
	mana_prop.connect('max_mana_changed', Callable(stats_bar, '_on_max_mana_changed'))
	mana_prop.emit_signal('max_mana_changed', mana_prop.get_max_mana())
	mana_prop.connect('mana_changed', Callable(stats_bar, '_on_mana_changed'))
	mana_prop.emit_signal('mana_changed', mana_prop.get_mana())
	var hungry_prop: HungryProperty = entity_data.stats.get_property(InitPropProviders.HUNGRY)
	hungry_prop.connect('max_hungry_changed', Callable(stats_bar, '_on_max_hungry_changed'))
	hungry_prop.emit_signal('max_hungry_changed', hungry_prop.get_max_hungry())
	hungry_prop.connect('hungry_changed', Callable(stats_bar, '_on_hungry_changed'))
	hungry_prop.emit_signal('hungry_changed', hungry_prop.get_hungry())
	# Player Hand
	hand = get_hand()
	hand.player = self
	# Fill
	var mypanel: MyPanel = ui.get_invent_panel()
	mypanel.fill_children(self)
	inventory = mypanel.get_inventory_tab()
	hand.set_item_hand_texture(inventory.get_hand().stack.item)


func _process(_delta: float) -> void:
	light_point.energy = remap(TimeManager.time_curve_value, 0, 1, 1, 0)


func _physics_process(_delta: float) -> void:
	if entity_data.is_dead or is_sleeping: return
	if knockback_vector == Vector2.ZERO:
		# Get the input direction and handle the movement/deceleration.
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
		var stats_move_speed = entity_data.stats.get_property(InitPropProviders.MOVE_SPEED).get_move_speed()
		if direction != Vector2.ZERO:
			if Input.is_action_just_pressed('ui_roll'):
				consume_hungry(ROLL_HUNGRY)
				print_debug('Rolou!')  # TODO: Implementar o movimento de rolagem.
			velocity = direction * stats_move_speed
			flip_texture()
			consume_hungry(WALKING_HUNGRY)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, stats_move_speed)
	else:  # Knockback
		velocity = knockback_vector
	# Setting state and animation and continuing movement
	set_animation()
	move_and_slide()

# SUPER
# Main
func heal(heal_value: float) -> void:
	super.heal(heal_value)
	var remaining = heal_value
	for c in 3:
		if remaining <= 0: break
		if PASSIVE_REGEN_VALUES[c] >= remaining:
			PASSIVE_REGEN_VALUES[c] -= remaining
			break
		else:
			remaining -= PASSIVE_REGEN_VALUES[c]
			PASSIVE_REGEN_VALUES[c] = 0


func hurt(final_dam: float, hit: HitData, hitbox_parent: Variant) -> void:
	super.hurt(final_dam, hit, hitbox_parent)
	consume_hungry(HURT_HUNGRY)
	var third_part = final_dam / 3.0
	PASSIVE_REGEN_VALUES[0] += third_part
	PASSIVE_REGEN_VALUES[1] += third_part
	PASSIVE_REGEN_VALUES[2] += final_dam - (third_part * 2)


func die(_attacker: LivingEntity) -> void:
	entity_data.is_dead = true
	ESSENCE_COUNTER -= 1
	ANIMATION.play('death')
	await ANIMATION.animation_finished
	var ui = get_ui()
	await ui.view.close_eyes()
	await ui.essence_vessel.discount_essence()
	if ESSENCE_COUNTER <= 0:
		get_tree().change_scene_to_file("res://client/screens/title_screen/TitleScreen.tscn")
	else:
		respawn()


func respawn() -> void:
	var health_prop: HealthProperty = entity_data.stats.get_property(InitPropProviders.HEALTH)
	health_prop.set_health(
		(health_prop.get_max_health() * .4) + PASSIVE_REGEN_VALUES[0]
	)
	PASSIVE_REGEN_VALUES[0] = PASSIVE_REGEN_VALUES[1]
	PASSIVE_REGEN_VALUES[1] = PASSIVE_REGEN_VALUES[2]
	PASSIVE_REGEN_VALUES[2] = 0
	get_ui().view.open_eyes()
	entity_data.is_dead = false
	set_invencibility(2.5)

# Animation
func set_animation() -> void:
	if entity_data.is_dead or is_sleeping: return
	var anim = 'idle'
	if direction != Vector2.ZERO: anim = 'walk'
	if ANIMATION.current_animation != anim: ANIMATION.play(anim)
	if not hand.is_using and hand.ITEM_HAND_ANIMATION.current_animation != anim: hand.ITEM_HAND_ANIMATION.play(anim)

# Handlers
func flip_texture() -> void:
	var mouse_direction = get_mouse_direction()
	var is_flip: bool = mouse_direction.x < 0
	TEXTURE.flip_h = is_flip
	if is_flip:
		hand.scale.x = -1
	else:
		hand.scale.x = 1

# MAIN
func consume_hungry(consume: float) -> void:
	var hungry_prop: HungryProperty = entity_data.stats.get_property(InitPropProviders.HUNGRY)
	if not hungry_prop.get_hungry() > 0:
		var health_prop: HealthProperty = entity_data.stats.get_property(InitPropProviders.HEALTH)
		health_prop.sub_health(consume)
		PASSIVE_REGEN_VALUES[0] += consume
	else:
		hungry_prop.sub_hungry(consume)


func sleep() -> void:
	is_sleeping = true
	entity_data.is_invincible = true
	TEXTURE.visible = false
	hand.ITEM_HAND_TEXTURE.visible = false
	await get_tree().create_timer(5).timeout
	is_sleeping = false
	entity_data.is_invincible = false
	hand.is_interacting = false
	TEXTURE.visible = true
	hand.ITEM_HAND_TEXTURE.visible = true
	var hp_prop: HealthProperty = entity_data.stats.get_property(InitPropProviders.HEALTH)
	hp_prop.add_health(PASSIVE_REGEN_VALUES[0])
	PASSIVE_REGEN_VALUES[0] = PASSIVE_REGEN_VALUES[1]
	PASSIVE_REGEN_VALUES[1] = PASSIVE_REGEN_VALUES[2]
	PASSIVE_REGEN_VALUES[2] = 0

# GETTERS AND SETTERS
# Nodes
func get_ui() -> WorldUI:
	return get_node('WorldUI')


func get_hand() -> PlayerHand:
	return get_node('Hand')


func get_mouse_direction() -> Vector2:
	return global_position.direction_to(get_global_mouse_position())

# HANDLERS
# Survivor level
func _on_surv_level_up() -> void:
	var health_prov = entity_data.stats.get_property(InitPropProviders.HEALTH)
	health_prov.add_max_health(10)
	health_prov.add_health(10)
	entity_data.stats.get_property(InitPropProviders.FORCE).add_force(2.5)
	entity_data.stats.get_property(InitPropProviders.RESISTANCE).add_resistance(0.5)
	entity_data.stats.get_property(InitPropProviders.PENETRATION).add_penetration(0.2)
