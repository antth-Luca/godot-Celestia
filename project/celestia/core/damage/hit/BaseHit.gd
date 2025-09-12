extends Node
class_name BaseHit

@onready var TEXTURE: Sprite2D = $Texture
@onready var ANIMATION: AnimationPlayer = $Animation

var source_entity: LivingEntity
var calc_use_speed: float

# GODOT
func _ready():
	flip_texture()

# MAIN
func initialize(source_entity_param: LivingEntity, calc_use_speed_param: float) -> void:
	source_entity = source_entity_param
	calc_use_speed = calc_use_speed_param


func flip_texture() -> void:
	var mouse_direction: Vector2 = source_entity.global_position.direction_to(source_entity.get_global_mouse_position())
	TEXTURE.flip_h = mouse_direction.x < 0

# GETTERS AND SETTERS
# HitData
func get_hit_data() -> HitData:
	return null
