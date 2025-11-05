extends Node2D
class_name World

var config := {}

# GODOT
func _ready() -> void:
	# Time
	TimeManager.initialize(12, $NaturalLight)
	# World config
	var config_file = FileAccess.open('res://saves/MyWorld/config/world_config.json', FileAccess.READ)
	if config_file:
		var content = config_file.get_as_text()
		config = JSON.parse_string(content)
	else:
		push_error('World: Error loading world settings.')
	# Spawn Player
	var player: Player = InitCreatures.PLAYER.get_registered()
	get_tree().current_scene.add_child(player)
	player.global_position = Vector2(169, 140)
	player.ESSENCE_COUNTER = config.get('max_resilient_essence')
	# TESTS CODE
	# Spawn Bed
	StructuresUtils.spawn_structure_in_position(
		InitStructures.BED.get_registered(),
		Vector2(179, 114)
	)
	# Spawn Furnace
	StructuresUtils.spawn_structure_in_position(
		InitStructures.STONE_FURNACE.get_registered(),
		Vector2(210, 114)
	)
	# Spawn Star Channel
	StructuresUtils.spawn_structure_in_position(
		InitStructures.STAR_CHANNEL.get_registered(),
		Vector2(241, 114)
	)
	# Spawn Star Forge
	StructuresUtils.spawn_structure_in_position(
		InitStructures.STAR_FORGE.get_registered(),
		Vector2(272, 114)
	)
	# Spawn Zombie
	var zombie: Zombie = InitCreatures.ZOMBIE.get_registered()
	get_tree().current_scene.add_child(zombie)
	zombie.global_position = Vector2(392, 269)
	# Spawn Chicken
	var chicken: Chicken = InitCreatures.CHICKEN.get_registered()
	get_tree().current_scene.add_child(chicken)
	chicken.global_position = Vector2(392, 269)
	# Spawn Bush
	StructuresUtils.spawn_structure_in_position(
		InitStructures.BUSH.get_registered(),
		Vector2(487, 117)
	)
	# Spawn Stick
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitRelics.JADE_CHALICE.get_registered()),
		Vector2(169, 165)
	)
	# Spawn Iron
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitWeapons.IRON_SWORD.get_registered()),
		Vector2(169, 180)
	)
	# Spawn Papyrus
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitItems.PAPYRUS.get_registered()),
		Vector2(169, 195)
	)

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
