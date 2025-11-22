extends BaseDimension
class_name CaveDimension

@onready var water_layer = $Terrain/CaveWater
@onready var stone_elevation_layer = $Terrain/StoneElevation
@onready var dust_layer = $Terrain/DustCover

# GODOT
func _ready() -> void:
	# TESTS CODE
	# Spawn Ruby pillar
	StructuresUtils.spawn_structure_in_position(
		InitStructures.RUBY_PILLAR.get_registered(),
		Vector2(180, 115), self
	)
	# Spawn Obsidian pillar
	StructuresUtils.spawn_structure_in_position(
		InitStructures.OBSIDIAN_PILLAR.get_registered(),
		Vector2(210, 115), self
	)
	# Spawn Moonstone pillar
	StructuresUtils.spawn_structure_in_position(
		InitStructures.MOONSTONE_PILLAR.get_registered(),
		Vector2(240, 115), self
	)

# GETTERS AND SETTERS
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

# Dust tile
func get_dust_in_tile(global_pos: Vector2) -> bool:
	var local_pos = dust_layer.to_local(global_pos)
	var coords = dust_layer.local_to_map(local_pos)
	var tile_id = dust_layer.get_cell_source_id(coords)
	return tile_id != -1


func get_dust_in_3x3_tiles(global_pos: Vector2) -> bool:
	var dust_tile_size := Vector2(dust_layer.tile_set.tile_size)
	for x in range(-1, 2):
		for y in range(-1, 2):
			var check_pos = global_pos + Vector2(x, y) * dust_tile_size
			if get_dust_in_tile(check_pos): return true
	return false
