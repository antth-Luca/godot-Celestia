extends BaseHit
class_name LightingHit

# SUPER
# Godot
func _ready() -> void:
	ANIMATION.play('flash')
	set_lifespan()


func _physics_process(_delta):
	pass

# Getters and setters
func set_lifespan() -> void:
	var timer := Timer.new()
	timer.wait_time = .8
	timer.one_shot = true
	timer.connect(
		'timeout',
		Callable(self, 'despawn_hit')
	)
	add_child(timer)
	timer.start()

func get_hit_data() -> HitData:
	return HitData.new(
		source_entity,
		HitData.PRIMITIVE_TYPE.PHYSIC,
		HitData.SPECIALIZED_TYPE.ELETRIC,
		HitData.SOURCE.SPELL,
		source_tool,
		[ EffectInstance.new(InitEffects.ELECTROCUTE, 10) ]
	)
