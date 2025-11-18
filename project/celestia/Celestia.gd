extends Node
class_name Celestia

const GAME_ID: String = 'celestia'
const DROPPED_ITEM_SCENE_PATH: String = 'res://core/world/dropped_items/DroppedItem.tscn'
const ITEM_SPRITE_PATH: String = 'res://assets/%s/textures/items/%s.png'
const SLOT_TYPE_SPRITE_PATH: String = 'res://assets/%s/interface/inventory/slots/types/%s.png'
const EFFECT_SPRITE_PATH: String = 'res://assets/%s/textures/effects/%s.png'
const PLANT_STRUCT_SPRITE_PATH: String = 'res://assets/%s/textures/structures/plants/%s.png'
const GAME_CONFIG_PATH: String = 'res://config/game_config.json'
const TRANSLATION_KEY_BASES: Dictionary = {
	ITEM = 'item.%s',
	ITEM_DESC = 'item.%s.description',
	RARITY = 'item.rarity.%s',
	ENCHANTMENT = 'item.enchantment.%s',
	SLOT = 'item.slot.%s',
	SECTION_TITLE = 'item.section.%s',
	STATS = 'ui.inventory.stats.%s',
	EFFECT = 'effect.%s',
	STRUCTURE = 'structure.%s',
	STRUCTURE_SECTION = 'structure.section.%s'
}
const FLOATING_INDICATOR: PackedScene = preload('res://core/entities/components/floating_indicator/FloatingIndicator.tscn')


func _ready():
	InitRarities.setup()
	InitMaterials.setup()
	InitEffects.setup()
	InitEnchantments.setup()
	InitItems.setup()
	InitAmmos.setup()
	InitFoods.setup()
	InitFuels.setup()
	InitSeeds.setup()
	InitFertilizers.setup()
	InitArmors.setup()
	InitWeapons.setup()
	InitTools.setup()
	InitRelics.setup()
	InitRecipes.setup()
	InitLootBoxes.setup()
	InitPropProviders.setup()
	InitHits.setup()
	InitCreatures.setup()
	InitStructures.setup()
	call_deferred('_go_to_next_scene')


func _go_to_next_scene():
	get_tree().change_scene_to_file('res://core/world/World.tscn')
