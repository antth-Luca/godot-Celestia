extends BaseStructure
class_name Bed

@onready var TEXTURE = $Texture
@onready var ANIMATION = $Animation

var stats: PropertyManager

# GODOT
func _init() -> void:
	stats = PropertyManager.create_manager({
		InitPropProviders.HEALTH: 3
	})


func _ready() -> void:
	var health_prop: HealthProperty = stats.get_property(InitPropProviders.HEALTH)
	# Health drained signal
	health_prop.connect('zero_health', Callable(self, 'destroy'))

# MAIN
func on_interact(_entity: LivingEntity) -> void:
	print_debug('Interagiu com a cama!')  # TODO: Implementar a sonequinha!


func destroy() -> void:
	queue_free()
