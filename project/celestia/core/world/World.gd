extends WorldEnvironment
class_name World

var config := {}
var world_state := {
	'defeated_bosses': 0
}

# GODOT
func _ready() -> void:
	# World config
	var config_file = FileAccess.open('res://saves/MyWorld/config/world_config.json', FileAccess.READ)
	if config_file:
		var content = config_file.get_as_text()
		config = JSON.parse_string(content)
	else:
		push_error('World: Error loading world settings.')
	# Time
	TimeManager.initialize(12)
	# TESTS CODE
	var surface: SurfaceDimension = get_or_create_dimension(InitDimensions.SURFACE)
	surface.spawn_player(null, Vector2(170, 140))

# GETTERS AND SETTERS
# World state
func get_defeated_bosses() -> int:
	return world_state['defeated_bosses']


func set_defeated_bosses(new_number: int) -> void:
	world_state['defeated_bosses'] = clamp(new_number, 0, 5)

# Nodes
func get_dimension(dim_name: String) -> Node2D:
	return get_node(dim_name)


func get_or_create_dimension(holder_dimension: DeferredHolder) -> BaseDimension:
	for dimension in get_children():
		if dimension.id.get_string() == holder_dimension.location.get_string():
			return dimension
	var create = holder_dimension.get_registered()
	add_child(create)
	return create
