extends StaticBody2D
class_name BaseStructure

@onready var TEXTURE = $Texture
@onready var ANIMATION = $Animation

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
