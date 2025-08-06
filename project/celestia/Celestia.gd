extends Node2D
class_name Celestia

const GAME_ID: String = "celestia"


func _ready():
	# MAIN CODE
	InitItems.setup()

	# TESTS CODE
	var dropped_item = preload("res://core/items/custom/DroppedItem.tscn")
	var drop = dropped_item.instantiate()
	drop.initialize(ItemStack.new(InitItems.EGG, 16))
	add_child(drop)
	drop.global_position = Vector2(208, 133)
	
	var drop2 = dropped_item.instantiate()
	drop2.initialize(ItemStack.new(InitItems.GOLD_INGOT, 5))
	add_child(drop2)
	drop2.global_position = Vector2(212, 133)
