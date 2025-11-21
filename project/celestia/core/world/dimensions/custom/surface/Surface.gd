extends BaseDimension
class_name SurfaceDimension

@onready var day_night_cycle_gradient: GradientTexture1D = load('res://assets/celestia/particles/daynightcycle-gradient-texture.tres')
@onready var water_layer = $Terrain/Water
@onready var sand_layer = $Terrain/Sand
@onready var dirt_elevation_layer = $Terrain/DirtElevation
@onready var grass_layer = $Terrain/Grass
@onready var natural_light = $NaturalLight

# GODOT
func _ready() -> void:
	# TESTS CODE
	# Spawn Player
	var player: Player = InitCreatures.PLAYER.get_registered()
	self.add_child(player)
	player.global_position = Vector2(170, 140)
	player.ESSENCE_COUNTER = get_world().config.get('max_resilient_essence')
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
		Vector2(180, 115), self
	)
	# Spawn Workbench
	StructuresUtils.spawn_structure_in_position(
		InitStructures.WORKBENCH.get_registered(),
		Vector2(210, 115), self
	)
	# Spawn Furnace
	StructuresUtils.spawn_structure_in_position(
		InitStructures.STONE_FURNACE.get_registered(),
		Vector2(240, 115), self
	)
	# Spawn Star Channel
	StructuresUtils.spawn_structure_in_position(
		InitStructures.STAR_CHANNEL.get_registered(),
		Vector2(270, 115), self
	)
	# Spawn Star Forge
	StructuresUtils.spawn_structure_in_position(
		InitStructures.STAR_FORGE.get_registered(),
		Vector2(300, 115), self
	)
	# Spawn Star Pillar
	StructuresUtils.spawn_structure_in_position(
		InitStructures.STAR_PILLAR.get_registered(),
		Vector2(330, 115), self
	)
	# Spawn Bush
	StructuresUtils.spawn_structure_in_position(
		InitStructures.BUSH.get_registered(),
		Vector2(490, 120), self
	)
	# Spawn Ruby Pillar
	StructuresUtils.spawn_structure_in_position(
		InitStructures.RUBY_PILLAR.get_registered(),
		Vector2(460, 120), self
	)
	# Spawn Obsidian Pillar
	StructuresUtils.spawn_structure_in_position(
		InitStructures.OBSIDIAN_PILLAR.get_registered(),
		Vector2(430, 120), self
	)
	# Spawn Moonstone Pillar
	StructuresUtils.spawn_structure_in_position(
		InitStructures.MOONSTONE_PILLAR.get_registered(),
		Vector2(400, 120), self
	)
	# Spawn Zombie
	var zombie: Zombie = InitCreatures.ZOMBIE.get_registered()
	self.add_child(zombie)
	zombie.global_position = Vector2(390, 270)
	# Spawn Chicken
	var chicken: Chicken = InitCreatures.CHICKEN.get_registered()
	self.add_child(chicken)
	chicken.global_position = Vector2(390, 270)
	# Spawn boss Ulken Golem
	var golem: UlkenGolem = InitCreatures.ULKEN_GOLEM.get_registered()
	self.add_child(golem)
	golem.global_position = Vector2(865, 294)
	# Spawn Stick
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitFuels.STICK.get_registered()),
		Vector2(170, 165), self
	)
	# Spawn Iron
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitItems.IRON_INGOT.get_registered()),
		Vector2(170, 180), self
	)
	# Spawn Papyrus
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitItems.LINKING_STAFF.get_registered()),
		Vector2(170, 195), self
	)
	# Spawn Rose
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitSeeds.ROSE.get_registered()),
		Vector2(170, 210), self
	)


func _process(_delta) -> void:
	natural_light.color = day_night_cycle_gradient.gradient.sample(TimeManager.time_curve_value)

# GETTERS AND SETTERS
# Nodes
func get_world() -> World:
	return get_parent()

# Water tile
func get_water_in_tile(global_pos: Vector2) -> bool:
	var local_pos = water_layer.to_local(global_pos)
	var coords = water_layer.local_to_map(local_pos)
	var tile_id = water_layer.get_cell_source_id(coords)
	return tile_id != -1


func get_water_in_3x3_tiles(global_pos: Vector2) -> bool:
	var water_tile_size := Vector2(water_layer.tile_set.tile_size)
	for x in range(-1, 2):
		for y in range(-1, 2):
			var check_pos = global_pos + Vector2(x, y) * water_tile_size
			if get_water_in_tile(check_pos): return true
	return false

# Grass tile
func get_grass_in_tile(global_pos: Vector2) -> bool:
	var local_pos = grass_layer.to_local(global_pos)
	var coords = grass_layer.local_to_map(local_pos)
	var tile_id = grass_layer.get_cell_source_id(coords)
	return tile_id != -1


func get_grass_in_3x3_tiles(global_pos: Vector2) -> bool:
	var grass_tile_size := Vector2(grass_layer.tile_set.tile_size)
	for x in range(-1, 2):
		for y in range(-1, 2):
			var check_pos = global_pos + Vector2(x, y) * grass_tile_size
			if get_grass_in_tile(check_pos): return true
	return false

# Sand tile
func get_sand_in_tile(global_pos: Vector2) -> bool:
	var local_pos = sand_layer.to_local(global_pos)
	var coords = sand_layer.local_to_map(local_pos)
	var tile_id = sand_layer.get_cell_source_id(coords)
	return tile_id != -1


func get_sand_in_3x3_tiles(global_pos: Vector2) -> bool:
	var sand_tile_size := Vector2(sand_layer.tile_set.tile_size)
	for x in range(-1, 2):
		for y in range(-1, 2):
			var check_pos = global_pos + Vector2(x, y) * sand_tile_size
			if get_sand_in_tile(check_pos): return true
	return false
