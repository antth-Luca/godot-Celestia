extends Node2D
class_name Celestia

const GAME_ID: String = "celestia"


func _ready():
	# MAIN CODE
	InitItems.setup()

	# TESTS CODE
	var dropped_item = preload("res://core/items/DroppedItem.tscn")
	var drop = dropped_item.instantiate()
	drop.initialize(ItemStack.new(InitItems.EGG, 16))
	add_child(drop)
	drop.global_position = Vector2(208, 133)
