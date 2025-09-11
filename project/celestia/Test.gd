extends Node2D


func _ready():
	# TESTS CODE
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitWeapons.IRON_SWORD.get_registered(), 1),
		Vector2(208, 133)
	)
