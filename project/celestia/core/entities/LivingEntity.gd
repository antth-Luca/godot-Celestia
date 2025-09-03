extends CharacterBody2D
class_name LivingEntity

@onready var TEXTURE: Sprite2D = $Texture
@onready var ANIMATION: AnimationPlayer = $Animation

var knockback_vector: Vector2 = Vector2.ZERO
var entity_data: EntityData
var direction: Vector2 = Vector2.ZERO

# GODOT
func _physics_process(_delta: float) -> void:
	# Knockback
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	else:
		# Get the input direction and handle the movement/deceleration.
		var stats_move_speed = entity_data.stats.get_property(InitPropProviders.MOVE_SPEED).get_move_speed()
		if direction != Vector2.ZERO:
			velocity = direction * stats_move_speed
			if direction.x != 0: TEXTURE.scale.x = sign(direction.x)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, stats_move_speed)
	# Setting state and animation and continuing movement
	set_animation()
	move_and_slide()

# GETTERS AND SETTERS
# Attack
func get_data_hit() -> HitData:
	return null

# Animation
func set_animation() -> void:
	var anim = 'idle'
	if direction != Vector2.ZERO:
		anim = 'walk'
	if ANIMATION.current_animation != anim:
		ANIMATION.play(anim)

# HANDLERS
func _on_hurtbox_area_entered(area) -> void:
	if area.is_in_group('hitbox'):
		var source_entity = area.get_parent()
		var hit: HitData = source_entity.get_data_hit()
		DamageManager.try_apply(hit, entity_data)
		apply_knockback(global_position, area.get_parent().global_position, hit.specialized_type)


func apply_knockback(attacker_pos: Vector2, target_pos: Vector2, hit_specialized_type: HitData.SPECIALIZED_TYPE = HitData.SPECIALIZED_TYPE.NONE) -> void:
	var multiplier: float = 120 if hit_specialized_type == HitData.SPECIALIZED_TYPE.EXPLOSION else 100
	knockback_vector = (attacker_pos - target_pos).normalized() * multiplier
	var knockback_tween: Tween = get_tree().create_tween()
	knockback_tween.tween_property(self, 'knockback_vector', Vector2.ZERO, .2)
	TEXTURE.modulate = Color.INDIAN_RED
	knockback_tween.tween_property(TEXTURE, 'modulate', Color.WHITE, .15)
