extends Node2D

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
	var player: Player = InitEntities.PLAYER.get_registered()
	get_tree().current_scene.add_child(player)
	player.global_position = Vector2(169, 104)
	player.ESSENCE_COUNTER = config.get('max_resilient_essence')
	# TESTS CODE
	# Spawn Furnace
	var furnace: StoneFurnace = InitStructures.STONE_FURNACE.get_registered()
	get_tree().current_scene.add_child(furnace)
	furnace.global_position = Vector2(487, 117)
	# Spawn Stick
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitFuels.STICK.get_registered(), 12),
		Vector2(169, 145)
	)
	# Spawn Egg
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitFoods.EGG.get_registered(), 12),
		Vector2(169, 160)
	)
