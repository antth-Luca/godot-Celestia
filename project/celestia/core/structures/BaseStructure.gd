extends Area2D
class_name BaseStructure

# MAIN
func on_interact(_entity: LivingEntity) -> void:
	pass

# HANDLERS
func _on_interaction_entity_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		body.hand.active_interacts.push_back(self)


func _on_interaction_entity_exited(body: Node2D) -> void:
	if body.is_in_group('player'):
		var interacts = body.hand.active_interacts
		var index = interacts.find(self)
		if index != -1: interacts.remove_at(index)
