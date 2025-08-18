extends Node2D
class_name Celestia

const GAME_ID: String = "celestia"


func _ready():
	# MAIN CODE
	InitRarities.setup()
	InitMaterials.setup()
	InitItems.setup()
	InitArmors.setup()

	# TESTS CODE
	var dropped_item = preload("res://core/items/DroppedItem.tscn")
	var drop = dropped_item.instantiate()
	drop.initialize(ItemStack.new(InitArmors.IRON_CHESTPLATE.get_registered(), 1))
	add_child(drop)
	drop.global_position = Vector2(208, 133)
	
	var drop2 = dropped_item.instantiate()
	drop2.initialize(ItemStack.new(InitItems.IRON_INGOT.get_registered(), 5))
	add_child(drop2)
	drop2.global_position = Vector2(212, 133)
