extends CharacterBody2D

@export var WATER_LAYER_PATH: NodePath
@export var LAND_LAYER_PATH: NodePath

@onready var WATER_TILE_LAYER = get_node(WATER_LAYER_PATH) as TileMapLayer
@onready var LAND_TILE_LAYER = get_node(LAND_LAYER_PATH) as TileMapLayer

@onready var TEXTURE = $Texture as Sprite2D
@onready var ANIMATION = $AnimationPlayer as AnimationPlayer
@onready var WALL_COLLISIONS = $WallCollision as CollisionShape2D
@onready var RECT_TARGET_CELL = $TargetCell as ColorRect

const SPEED = 80.0
const AIR_FRICTION = 0.5

var direction = Vector2.ZERO
var target_cell = Vector2.ZERO
var is_jumping = false
var is_hurted = false


func _physics_process(_delta):
	if is_jumping: return

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	if direction != Vector2.ZERO:
		velocity = velocity.lerp(direction * SPEED, AIR_FRICTION)
		if direction.x != 0: TEXTURE.scale.x = sign(direction.x)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	set_target_cell()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and not is_jumping:
		is_jumping = true
		ANIMATION.play("jump")
		if is_valid_cell():
			var jump_tween = create_tween()
			jump_tween.tween_property(
				self,
				"position",
				target_cell,
				0.5
			)
			await jump_tween.finished
		else:
			await ANIMATION.animation_finished
		is_jumping = false

	set_state()
	move_and_slide()


func set_target_cell():
	target_cell = global_position + (velocity * 0.6)
	RECT_TARGET_CELL.position = velocity * 0.6 + Vector2(-8, 8)


func is_valid_cell() -> bool:
	var world_cell = LAND_TILE_LAYER.local_to_map(LAND_TILE_LAYER.to_local(target_cell))
	
	var land_tile_id = LAND_TILE_LAYER.get_cell_source_id(world_cell)
	var water_tile_id = WATER_TILE_LAYER.get_cell_source_id(world_cell)

	if water_tile_id == -1 and land_tile_id != 2:
		return true

	return false


func set_state():
	var state = "idle"
	
	if direction != Vector2.ZERO:
		state = "walk"

	if is_hurted:
		state = "hurt"

	if ANIMATION.current_animation != state:
		ANIMATION.play(state)
