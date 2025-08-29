extends Node2D


func _ready():
	# TESTS CODE
	var dropped_item = preload("res://core/items/DroppedItem.tscn")
	var drop = dropped_item.instantiate()
	drop.initialize(ItemStack.new(InitItems.IRON_INGOT.get_registered(), 10))
	add_child(drop)
	drop.global_position = Vector2(208, 133)
