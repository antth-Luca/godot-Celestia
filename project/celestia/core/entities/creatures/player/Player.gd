extends CharacterBody2D
class_name Player

@onready var TEXTURE: Sprite2D = $Texture
@onready var ANIMATION: AnimationPlayer = $Animation

var stats: PropertyManager
var direction: Vector2 = Vector2.ZERO
var is_hurted: bool = false

# GODOT
func _ready():
	stats = PropertyManager.create_manager({
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
		InitPropProviders.COOLDOWN_REDUCTION: 0
	})

	EventBus.client_player.connect('level_up', Callable(self, '_on_surv_level_up'))


func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	# Get the input direction and handle the movement/deceleration.
	var stats_move_speed = stats.get_property(InitPropProviders.MOVE_SPEED).get_move_speed()
	if direction != Vector2.ZERO:
		velocity = direction * stats_move_speed
		if direction.x != 0: TEXTURE.scale.x = sign(direction.x)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, stats_move_speed)
	# Setting state and animation and continuing movement
	set_state()
	move_and_slide()

# GETTERS AND SETTERS
# Nodes
func get_ui():
	return get_node('WorldUI')

# State
func set_state() -> void:
	var state = "idle"
	if direction != Vector2.ZERO:
		state = "walk"
	if is_hurted:
		state = "hurt"
	if ANIMATION.current_animation != state:
		ANIMATION.play(state)

# HANDLERS
func _on_surv_level_up() -> void:
	var health_prov = stats.get_property(InitPropProviders.HEALTH)
	health_prov.add_max_health(10)
	health_prov.add_health(10)
	stats.get_property(InitPropProviders.FORCE).add_force(2.5)
	stats.get_property(InitPropProviders.RESISTANCE).add_resistance(0.5)
	stats.get_property(InitPropProviders.PENETRATION).add_penetration(0.2)
