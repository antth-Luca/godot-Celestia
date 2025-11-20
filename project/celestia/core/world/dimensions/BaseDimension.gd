extends Node2D
class_name BaseDimension

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseItem: Item ID already set. It cannot be changed after initialization.')
		id = new_id

# MAIN
func get_living_entites_in(global_pos: Vector2, range_search: float) -> Array:
	var space_state = get_world_2d().direct_space_state
	# Cria um shape circular para a detecção
	var shape = CircleShape2D.new()
	shape.radius = range_search
	# Define parâmetros da consulta
	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.transform = Transform2D(0, global_pos)
	# Executa a detecção
	var results = space_state.intersect_shape(query)
	# Filtra apenas CharacterBody2D (ou subclasses)
	var characters: Array = []
	for result in results:
		var collider = result.collider
		if collider is LivingEntity:
			characters.append(collider)
	return characters
