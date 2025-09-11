extends Node
class_name Celestia

const GAME_ID: String = 'celestia'
const DROPPED_ITEM_SCENE_PATH: String = 'res://core/items/DroppedItem.tscn'
const ITEM_SPRITE_PATH: String = 'res://assets/%s/textures/items/%s.png'
const SLOT_TYPE_SPRITE_PATH: String = 'res://assets/%s/interface/inventory/slots/types/%s.png'
const GAME_CONFIG_PATH: String = 'res://config/game_config.json'
const TRANSLATION_FILE_PATH: String = 'res://assets/celestia/lang/%s.json'
const TRANSLATION_KEY_BASES: Dictionary = {
	ITEM = '%s.item.%s.name',
	RARITY = '%s.item.rarity.%s',
	STATS = '%s.ui.inventory.stats.%s'
}


func _ready():
	InitRarities.setup()
	InitMaterials.setup()
	InitPropProviders.setup()
	InitItems.setup()
	InitArmors.setup()
	InitWeapons.setup()
	call_deferred('_go_to_next_scene')


func _go_to_next_scene():
	get_tree().change_scene_to_file('res://Test.tscn')
