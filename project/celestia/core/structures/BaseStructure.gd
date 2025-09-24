extends StaticBody2D
class_name BaseStructure

@onready var TEXTURE: Sprite2D = $Texture
@onready var ANIMATION: AnimationPlayer = $Animation

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

# HANDLERS
func _on_interaction_entity_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		body.hand.register_interaction(self)


func _on_interaction_entity_exited(body: Node2D) -> void:
	if body.is_in_group('player'):
		body.hand.unregister_interaction(self)
