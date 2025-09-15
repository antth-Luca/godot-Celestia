extends Node2D


func _ready():
	var player = InitEntities.PLAYER.get_listed().instantiate()
	get_tree().current_scene.add_child(player)
	player.global_position = Vector2(169, 104)
	# TESTS CODE
	# Zombie
	var zombie = InitEntities.ZOMBIE.get_listed().instantiate()
	get_tree().current_scene.add_child(zombie)
	zombie.global_position = Vector2(487, 117)
	# Sword
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitWeapons.IRON_SWORD.get_registered(), 1),
		Vector2(208, 133)
	)
