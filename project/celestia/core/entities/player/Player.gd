extends CharacterBody2D

@onready var TEXTURE: Sprite2D = $Texture
@onready var ANIMATION: AnimationPlayer = $Animation

var stats: PlayerStats = PlayerStats.new()
var level: SurvivorLevelsManager = SurvivorLevelsManager.new()

var direction: Vector2 = Vector2.ZERO
var is_hurted: bool = false

# MAIN
func _physics_process(_delta) -> void:
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	if direction != Vector2.ZERO:
		velocity = direction * stats.get_move_speed()
		if direction.x != 0: TEXTURE.scale.x = sign(direction.x)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, stats.get_move_speed())
	# Setting state and animation and continuing movement
	_set_state()
	move_and_slide()


func _set_state() -> void:
	var state = "idle"
	if direction != Vector2.ZERO:
		state = "walk"
	if is_hurted:
		state = "hurt"
	if ANIMATION.current_animation != state:
		ANIMATION.play(state)
