extends Node2D
class_name BaseDimension

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseItem: Item ID already set. It cannot be changed after initialization.')
		id = new_id

# GETTERS AND SETTERS
# Nodes
# Nodes
func get_world() -> World:
	return get_parent()

# Others
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

# MAIN
func spawn_player(player: Player = null, at_pos: Vector2 = Vector2.ZERO) -> void:
	# Definitive code
	var has_player: bool = true
	if not player:
		has_player = false
		player = InitCreatures.PLAYER.get_registered()
	self.add_child(player)
	if not has_player: player.global_position = at_pos
	player.ESSENCE_COUNTER = get_world().config.get('max_resilient_essence')
	# Test
	if not has_player:
		var relics: Array = [
			InitRelics.EXPLORERS_KIT,
			InitRelics.BLOOD_ORB,
			InitRelics.VITAL_CORE,
			InitRelics.JADE_CHALICE,
			InitRelics.ARCANE_LINES,
			InitRelics.COIN_OF_BABYLON,
			InitRelics.COLLECTORS_GLOVE,
			InitRelics.PERFECTIONISTS_GLOVE,
			InitRelics.LOTUS_BLADES,
			InitRelics.MECHANICAL_HEART,
			InitRelics.HEART_OF_THE_STORM,
			InitRelics.CLAWED_GLOVE,
			InitRelics.PALE_ROSE,
			InitRelics.MAGMA_CARAPACE,
			InitRelics.ROSE_OF_JERICHO,
			InitRelics.CROWN_OF_LUCIDITY,
			InitRelics.WINGED_SOCKS,
			InitRelics.SHATTERED_AEGIS,
			InitRelics.EYE_OF_THE_STORM,
			InitRelics.COSMIC_FOCUS
		]
		for relic_holder in relics:
			player.inventory.add_item_to_backpack(ItemStack.new(relic_holder.get_registered()))


func remove_player(player: Player) -> void:
	var has_someone: bool = false
	for node in get_children():
		if node == player:
			remove_child(node)
			continue
		if node.is_in_group('Player'):
			has_someone = true
	if not has_someone: queue_free()
