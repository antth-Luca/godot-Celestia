extends BaseRelic
class_name CoinOfBabylonRelic

const BUFF_LUCK: int = 2

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.RARE.get_registered()
	incompabilities = [ InitRelics.COIN_OF_BABYLON, InitRelics.COLLECTORS_GLOVE, InitRelics.PERFECTIONISTS_GLOVE, InitRelics.CYCLOPS_MASK ]

# Getters and setters
func get_tooltip() -> Array[String]:
	var lines: Array[String] = super.get_tooltip()
	lines.insert(3, '[color=%s]    +%s %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		BUFF_LUCK, tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'LC')
	])
	return lines

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.LUCK).add_luck(BUFF_LUCK)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.LUCK).sub_luck(BUFF_LUCK)
