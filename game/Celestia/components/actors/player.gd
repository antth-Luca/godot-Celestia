extends CharacterBody2D

@export var WATER_LAYER_PATH: NodePath
@export var LAND_LAYER_PATH: NodePath

@onready var WATER_TILE_LAYER = get_node(WATER_LAYER_PATH) as TileMapLayer
@onready var LAND_TILE_LAYER = get_node(LAND_LAYER_PATH) as TileMapLayer

@onready var TEXTURE = $Texture as Sprite2D
@onready var ANIMATION = $AnimationPlayer as AnimationPlayer
@onready var WALL_COLLISIONS = $WallCollision as CollisionShape2D
@onready var TARGET_CELL = $TargetCell as ColorRect

const SPEED = 80.0
const AIR_FRICTION = 0.5

var direction = Vector2.ZERO
var is_jumping = false
var is_hurted = false


func _physics_process(_delta):
	if is_jumping: return

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	# TODO: Remover depois
	TARGET_CELL.position = Vector2.ZERO.lerp(direction * SPEED, AIR_FRICTION) * 0.6 + Vector2(-8, 8)
	if direction != Vector2.ZERO:
		velocity = velocity.lerp(direction * SPEED, AIR_FRICTION)
		if direction.x != 0: TEXTURE.scale.x = sign(direction.x)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and not is_jumping and is_valid_cell():
		is_jumping = true
		ANIMATION.play("jump")
		var jump_tween = create_tween()
		jump_tween.tween_property(
			self,
			"position",
			global_position + (velocity * 0.6),
			0.5
		)
		await jump_tween.finished
		is_jumping = false

	set_state()
	move_and_slide()


func is_valid_cell() -> bool:
	return true

	var ID_WATER_LAYER = 0
	var ID_LAND_LAYER = 1
	var jump_target = global_position + (velocity * 0.6)

	var cell_target = WATER_TILE_LAYER.local_to_map(WATER_TILE_LAYER.to_local(jump_target))
	var water_id = WATER_TILE_LAYER.get_cell_source_id(cell_target)
	if water_id:
		print("É água")
		return false

	var land_id = LAND_TILE_LAYER.get_cell_source_id(cell_target)
	var land_tile_data = LAND_TILE_LAYER.get_cell_tile_data(cell_target)
	if land_tile_data and land_tile_data.get_collision_polygons_count(ID_LAND_LAYER) > 0:
		print("É terra com colisão")
		return false

	print("Pode andar")
	return true


func set_state():
	var state = "idle"
	
	if direction != Vector2.ZERO:
		state = "walk"

	if is_hurted:
		state = "hurt"

	if ANIMATION.current_animation != state:
		ANIMATION.play(state)
