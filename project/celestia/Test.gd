extends Node2D


func _ready():
	# TESTS CODE
	var dropped_item = preload("res://core/items/DroppedItem.tscn")
	var drop = dropped_item.instantiate()
	drop.initialize(ItemStack.new(InitWeapons.IRON_SWORD.get_registered(), 1))
	add_child(drop)
	drop.global_position = Vector2(208, 133)
