extends CharacterBody2D
class_name BaseHit

@onready var TEXTURE: Sprite2D = $Texture
@onready var ANIMATION: AnimationPlayer = $Animation

var speed: float = 100
var direction: Vector2  # Filled on #_ready()
var calc_max_distance: Vector2  # Filled on #_ready()
var hit_max_distance: float = 20

var source_entity: LivingEntity  # Filled on #initialize()
var range_factor: float  # Filled on #initialize()
var damage_factor: float  # Filled on #initialize()

# GODOT
func _ready():
	direction = Vector2.RIGHT.rotated(global_rotation)
	calc_max_distance = global_position + direction.normalized() * (
		(source_entity.entity_data.stats.get_property(InitPropProviders.RANGE).get_range() * range_factor) * hit_max_distance 
	)
	flip_texture()


func _physics_process(delta):
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	_on_collide(collision)
	if global_position >= calc_max_distance: despawn_hit()

# MAIN
func initialize(source_entity_param: LivingEntity, range_factor_param: float, damage_factor_param: float) -> void:
	source_entity = source_entity_param
	range_factor = range_factor_param
	damage_factor = damage_factor_param


func flip_texture() -> void:
	var mouse_direction: Vector2 = source_entity.global_position.direction_to(source_entity.get_global_mouse_position())
	TEXTURE.flip_h = mouse_direction.x < 0


func despawn_hit() -> void:
	queue_free()

# GETTERS AND SETTERS
# Source entity
func get_source_entity() -> LivingEntity:
	return source_entity

# HitData
func get_hit_data() -> HitData:
	return null

# HANDLERS
func _on_collide(collision: KinematicCollision2D) -> void:
	if collision == null or source_entity == collision.get_collider(): return
	despawn_hit()
