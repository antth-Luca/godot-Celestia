extends StaticBody2D
class_name BaseStructure

const hurt_color: Color = Color.INDIAN_RED
const indestructible_color: Color = Color.WHITE

@onready var TEXTURE: Sprite2D = $Texture

var structure_data: StructureData

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseItem: Item ID already set. It cannot be changed after initialization.')
		id = new_id

# GODOT
func _ready() -> void:
	# Shader
		TEXTURE.material.set_shader_parameter('blink_color', hurt_color)

# MAIN
func _set_outline(state: bool) -> void:
	TEXTURE.material.set_shader_parameter('outline_enabled', state)


func add_highlight() -> void:
	_set_outline(true)


func remove_highlight() -> void:
	_set_outline(false)


func on_interact(_entity: LivingEntity) -> void: pass


func restore(restore_value: float) -> void:
	var hp_prop: HealthProperty = structure_data.stats.get_property(InitPropProviders.HEALTH)
	hp_prop.add_health(restore_value)


func damage(final_dam: float, hit: HitData, hitbox_parent: Variant) -> void:
	var hp_prop: HealthProperty = structure_data.stats.get_property(InitPropProviders.HEALTH)
	hp_prop.sub_health(final_dam)
	if hitbox_parent is BaseHit: hitbox_parent._on_hurt_entity()
	if hp_prop.get_health() <= 0:
		destroy(hit.attacker)
		return
	var blink_tween: Tween = create_tween()
	TEXTURE.material.set_shader_parameter('blink_value', 1.0)
	blink_tween.tween_property(TEXTURE.material, 'shader_parameter/blink_value', 0, .3).from(1.0)


func destroy(_attacker: LivingEntity) -> void:
	queue_free()

# HANDLERS
func _on_hurtbox_area_entered(hitbox) -> void:
	if hitbox.is_in_group('hitbox'):
		DamageManager.try_apply_structure(hitbox.get_parent(), self)


func _on_interaction_entity_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		body.hand.register_interaction(self)


func _on_interaction_entity_exited(body: Node2D) -> void:
	if body.is_in_group('player'):
		body.hand.unregister_interaction(self)
