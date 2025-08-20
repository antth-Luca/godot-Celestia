extends Node
class_name Celestia

const GAME_ID: String = "celestia"


func _ready():
	InitRarities.setup()
	InitMaterials.setup()
	InitItems.setup()
	InitArmors.setup()
	InitPropProviders.setup()
	call_deferred("_go_to_next_scene")


func _go_to_next_scene():
	get_tree().change_scene_to_file("res://Test.tscn")
