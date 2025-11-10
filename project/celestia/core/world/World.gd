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
		ItemStack.new(InitFuels.STICK.get_registered()),
		Vector2(169, 165)
	)
	# Spawn Iron
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitItems.IRON_INGOT.get_registered()),
		Vector2(169, 180)
	)
	# Spawn Papyrus
	DroppedItemUtils.drop_item_in_position(
		#ItemStack.new(InitItems.PAPYRUS.get_registered()),
		ItemStack.new(InitFertilizers.BONE.get_registered()),
		Vector2(169, 195)
	)
	# Spawn Rose
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitSeeds.ROSE.get_registered()),
		Vector2(169, 210)
	)

# MAIN
func get_water_in_3x3_tiles(global_pos: Vector2) -> bool:
	var water_layer: TileMapLayer = get_node('Terrain/Water')
	var water_tile_size := Vector2(water_layer.tile_set.tile_size)
	for x in range(-1, 2):
		for y in range(-1, 2):
			var check_pos = global_pos + Vector2(x, y) * water_tile_size
			var local_pos = water_layer.to_local(check_pos)
			var coords = water_layer.local_to_map(local_pos)
			var tile_id = water_layer.get_cell_source_id(coords)
			if tile_id != -1: return true
	return false


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
