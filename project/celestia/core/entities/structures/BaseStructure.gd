extends StaticBody2D
class_name BaseStructure

const hurt_color: Color = Color.DARK_SALMON
const indestructible_color: Color = Color.WHITE

@onready var TEXTURE: Sprite2D = $Texture
@onready var ANIMATION: AnimationPlayer = $Animation

var structure_data: StructureData

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseItem: Item ID already set. It cannot be changed after initialization.')
		id = new_id

# MAIN
func on_interact(_entity: LivingEntity) -> void:
	pass


func add_highlight() -> void:
	TEXTURE.material.set_shader_parameter('enabled', true)


func remove_highlight() -> void:
	TEXTURE.material.set_shader_parameter('enabled', false)


func restore(restore_value: float) -> void:
	var hp_prop: HealthProperty = structure_data.stats.get_property(InitPropProviders.HEALTH)
	hp_prop.add_health(restore_value)


func damage(final_dam: float, hit: HitData, hitbox_parent: Variant) -> void:
	var hp_prop: HealthProperty = structure_data.stats.get_property(InitPropProviders.HEALTH)
	hp_prop.sub_health(final_dam)
	# TODO: Adicionar representação visual do dano.
	if hitbox_parent is BaseHit: hitbox_parent._on_hurt_entity()
	if hp_prop.get_health() <= 0: destroy(hit.attacker)


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
