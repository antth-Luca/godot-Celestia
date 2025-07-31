extends Node2D
class_name Celestia

const GAME_ID: String = "celestia"


func _ready():
	# TESTS CODE
	var dropped_item = preload("res://core/items/DroppedItem.tscn")
	var drop = dropped_item.instantiate()
	drop.initialize(ItemStack.new('egg', 16))
	add_child(drop)
	drop.global_position = Vector2(208, 133)

	# MAIN CODE
	InitItems.setup()
