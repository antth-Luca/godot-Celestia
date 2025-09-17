extends Node2D

const real_sec_to_ingame_min_factor: float = 60

@onready var natural_light: CanvasModulate = $NaturalLight
@onready var day_night_cycle_gradient: GradientTexture1D = load('res://assets/celestia/particles/daynightcycle-gradient-texture.tres')

var config := {}
# World time
var initial_hour: float = 12
var time: float = 0

# GODOT
func _ready() -> void:
	# Time
	time = initial_hour * real_sec_to_ingame_min_factor
	# World config
	var config_file = FileAccess.open('res://saves/MyWorld/config/world_config.json', FileAccess.READ)
	if config_file:
		var content = config_file.get_as_text()
		config = JSON.parse_string(content)
	else:
		push_error('World: Error loading world settings.')
	# Spawn Player
	var player: Player = InitEntities.PLAYER.get_listed().instantiate()
	get_tree().current_scene.add_child(player)
	player.global_position = Vector2(169, 104)
	player.ESSENCE_COUNTER = config.get('max_resilient_essence')
	# TESTS CODE
	# Spawn Zombie
	var zombie: Zombie = InitEntities.ZOMBIE.get_listed().instantiate()
	get_tree().current_scene.add_child(zombie)
	zombie.global_position = Vector2(487, 117)
	# Spawn Sword
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitWeapons.IRON_SWORD.get_registered(), 1),
		Vector2(208, 133)
	)


func _process(delta: float) -> void:
	time += delta
	var color_time_value = (sin(time - PI / 2) + 1.0) / 2.0
	natural_light.color = day_night_cycle_gradient.gradient.sample(color_time_value)
