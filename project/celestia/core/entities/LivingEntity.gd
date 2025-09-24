extends CharacterBody2D
class_name LivingEntity

const hurt_color: Color = Color.INDIAN_RED
const invencible_color: Color = Color.WHITE

@onready var TEXTURE: Sprite2D = $Texture
@onready var ANIMATION: AnimationPlayer = $Animation

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseItem: Item ID already set. It cannot be changed after initialization.')
		id = new_id
var direction: Vector2 = Vector2.ZERO
var knockback_vector: Vector2 = Vector2.ZERO
var entity_data: EntityData

# GODOT
func _ready() -> void:
	# Shader
	TEXTURE.material.set_shader_parameter('blink_color', hurt_color)


func _physics_process(_delta: float) -> void:
	if entity_data.is_dead: return
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
func heal(heal_value: float) -> void:
	var hp_prop: HealthProperty = entity_data.stats.get_property(InitPropProviders.HEALTH)
	hp_prop.add_health(heal_value)


func hurt(final_dam: float, hit: HitData, hitbox_parent: Variant) -> void:
	var hp_prop: HealthProperty = entity_data.stats.get_property(InitPropProviders.HEALTH)
	hp_prop.sub_health(final_dam)
	apply_knockback(hit.attacker.global_position, hit.specialized_type)
	if hitbox_parent is BaseHit: hitbox_parent._on_hurt_entity()
	if hp_prop.get_health() <= 0: die(hit.attacker)


func die(_attacker: LivingEntity) -> void:
	entity_data.is_dead = true
	ANIMATION.play('death')
	await ANIMATION.animation_finished
	queue_free()

# GETTERS AND SETTERS
# Entity data
func set_invencibility(invenc_time: float) -> void:
	entity_data.is_invincible = true
	# Blink
	var blink_tween: Tween = create_tween()
	blink_tween.set_loops()
	TEXTURE.material.set_shader_parameter('blink_color', invencible_color)
	blink_tween.tween_property(TEXTURE.material, 'shader_parameter/blink_value', 1.0, .15)
	blink_tween.tween_property(TEXTURE.material, 'shader_parameter/blink_value', 0, .15).from(1.0)
	# Timer
	var timer := Timer.new()
	timer.wait_time = invenc_time
	timer.one_shot = true
	add_child(timer)
	timer.start()
	# Deactivate
	await timer.timeout
	entity_data.is_invincible = false
	blink_tween.kill()
	TEXTURE.material.set_shader_parameter('blink_value', 0)
	TEXTURE.material.set_shader_parameter('blink_color', hurt_color)
	timer.queue_free()

# Animation
func set_animation() -> void:
	if entity_data.is_dead: return
	var anim = 'idle'
	if direction != Vector2.ZERO:
		anim = 'walk'
	if ANIMATION.current_animation != anim:
		ANIMATION.play(anim)

# HANDLERS
func _on_hurtbox_area_entered(hitbox) -> void:
	if not entity_data.is_dead and hitbox.is_in_group('hitbox'):
		DamageManager.try_apply(hitbox.get_parent(), self)


func flip_texture() -> void:
	TEXTURE.flip_h = direction.x < 0


func apply_knockback(attacker_pos: Vector2, hit_specialized_type: HitData.SPECIALIZED_TYPE = HitData.SPECIALIZED_TYPE.NONE) -> void:
	var multiplier: float = 120 if hit_specialized_type == HitData.SPECIALIZED_TYPE.EXPLOSION else 100
	knockback_vector = (global_position - attacker_pos).normalized() * multiplier
	var knockback_tween: Tween = get_tree().create_tween()
	knockback_tween.tween_property(self, 'knockback_vector', Vector2.ZERO, .2)
	TEXTURE.material.set_shader_parameter('blink_value', 1.0)
	knockback_tween.tween_property(TEXTURE.material, 'shader_parameter/blink_value', 0, .15).from(1.0)
