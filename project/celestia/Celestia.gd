extends Node
class_name Celestia

const GAME_ID: String = 'celestia'
const DROPPED_ITEM_SCENE_PATH: String = 'res://core/world/dropped_items/DroppedItem.tscn'
const ITEM_SPRITE_PATH: String = 'res://assets/%s/textures/items/%s.png'
const SLOT_TYPE_SPRITE_PATH: String = 'res://assets/%s/interface/inventory/slots/types/%s.png'
const GAME_CONFIG_PATH: String = 'res://config/game_config.json'
const TRANSLATION_FILE_PATH: String = 'res://assets/celestia/lang/%s.json'
const TRANSLATION_KEY_BASES: Dictionary = {
	ITEM = 'item.%s.name',
	RARITY = 'item.rarity.%s',
	STATS = 'ui.inventory.stats.%s'
}


func _ready():
	InitRarities.setup()
	InitMaterials.setup()
	InitItems.setup()
	InitFoods.setup()
	InitArmors.setup()
	InitWeapons.setup()
	InitTools.setup()
	InitRecipes.setup()
	InitLootBoxes.setup()
	InitPropProviders.setup()
	InitHits.setup()
	InitEntities.setup()
	InitStructures.setup()
	call_deferred('_go_to_next_scene')


func _go_to_next_scene():
	get_tree().change_scene_to_file('res://core/world/World.tscn')
