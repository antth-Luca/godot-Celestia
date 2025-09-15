extends CharacterBody2D
class_name LivingEntity

@onready var TEXTURE: Sprite2D = $Texture
@onready var ANIMATION: AnimationPlayer = $Animation

var direction: Vector2 = Vector2.ZERO
var knockback_vector: Vector2 = Vector2.ZERO
var entity_data: EntityData
var is_dead: bool = false

# GODOT
func _ready() -> void:
	var health_prop: HealthProperty = entity_data.stats.get_property(InitPropProviders.HEALTH)
	# Health drained
	health_prop.connect('zero_health', Callable(self, 'die'))


func _physics_process(_delta: float) -> void:
	if is_dead: return
	# Knockback
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	else:
		# Get the input direction and handle the movement/deceleration.
		var stats_move_speed = entity_data.stats.get_property(InitPropProviders.MOVE_SPEED).get_move_speed()
		if direction != Vector2.ZERO:
			velocity = direction * stats_move_speed
			flip_texture()
		else:
			velocity = velocity.move_toward(Vector2.ZERO, stats_move_speed)
	# Setting state and animation and continuing movement
	set_animation()
	move_and_slide()

# MAIN
func die() -> void:
	is_dead = true
	ANIMATION.play('death')
	await ANIMATION.animation_finished
	queue_free()

# GETTERS AND SETTERS
# Animation
func set_animation() -> void:
	if is_dead: return
	var anim = 'idle'
	if direction != Vector2.ZERO:
		anim = 'walk'
	if ANIMATION.current_animation != anim:
		ANIMATION.play(anim)

# HANDLERS
func _on_hurtbox_area_entered(hitbox) -> void:
	if not is_dead and hitbox.is_in_group('hitbox'):
		var hitbox_parent = hitbox.get_parent()
		var hitdata: HitData = hitbox_parent.get_hit_data()
		if DamageManager.try_apply(hitdata, entity_data):
			if hitbox_parent is BaseHit: hitbox_parent._on_hurt_entity()
			apply_knockback(global_position, hitbox_parent.get_source_entity().global_position, hitdata.specialized_type)


func flip_texture() -> void:
	TEXTURE.flip_h = direction.x < 0


func apply_knockback(attacker_pos: Vector2, target_pos: Vector2, hit_specialized_type: HitData.SPECIALIZED_TYPE = HitData.SPECIALIZED_TYPE.NONE) -> void:
	var multiplier: float = 120 if hit_specialized_type == HitData.SPECIALIZED_TYPE.EXPLOSION else 100
	knockback_vector = (attacker_pos - target_pos).normalized() * multiplier
	var knockback_tween: Tween = get_tree().create_tween()
	knockback_tween.tween_property(self, 'knockback_vector', Vector2.ZERO, .2)
	TEXTURE.modulate = Color.INDIAN_RED
	knockback_tween.tween_property(TEXTURE, 'modulate', Color.WHITE, .15)
