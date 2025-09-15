extends Node2D
class_name BaseHit

@onready var TEXTURE: Sprite2D = $Texture
@onready var ANIMATION: AnimationPlayer = $Animation
# Move and limit range variables
var speed: float = 100
var direction: Vector2  # Filled on #_ready()
# Sources
var source_entity: LivingEntity  # Filled on #initialize()
var source_tool: BaseTool  # Filled on #initialize()

# GODOT
func _ready():
	direction = global_position.direction_to(source_entity.get_mouse_direction())
	rotation_degrees = rad_to_deg(direction.angle())
	set_lifespan()


func _physics_process(delta):
	translate(direction * delta * speed)

# MAIN
func initialize(source_entity_param: LivingEntity, source_tool_param: BaseTool) -> void:
	source_entity = source_entity_param
	source_tool = source_tool_param


func despawn_hit() -> void:
	queue_free()

# GETTERS AND SETTERS
# Source entity
func get_source_entity() -> LivingEntity:
	return source_entity

# Lifespan
func set_lifespan() -> void:
	var timer := Timer.new()
	timer.wait_time = (
		source_entity.entity_data.stats.get_property(InitPropProviders.RANGE).get_range() *
		source_tool.base_lifespan
	)
	timer.one_shot = true
	timer.connect(
		'timeout',
		Callable(self, 'despawn_hit')
	)
	add_child(timer)
	timer.start()

# HitData
func get_hit_data() -> HitData:
	return null

# HANDLERS
func _on_hurt_entity() -> void:
	return
