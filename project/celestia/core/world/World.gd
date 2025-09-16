extends Node2D

var config := {}

func _ready():
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
	# Zombie
	var zombie: Zombie = InitEntities.ZOMBIE.get_listed().instantiate()
	get_tree().current_scene.add_child(zombie)
	zombie.global_position = Vector2(487, 117)
	# Sword
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitWeapons.IRON_SWORD.get_registered(), 1),
		Vector2(208, 133)
	)
