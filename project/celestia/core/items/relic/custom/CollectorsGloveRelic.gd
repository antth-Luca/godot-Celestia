extends BaseRelic
class_name CollectorsGloveRelic

const BUFF_LUCK: int = CoinOfBabylonRelic.BUFF_LUCK
const BUFF_ARMOR: float = 1

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.RARE.get_registered()

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.LUCK).add_luck(BUFF_LUCK)
	player_stats.get_property(InitPropProviders.ARMOR).add_armor(BUFF_ARMOR)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.LUCK).sub_luck(BUFF_LUCK)
	player_stats.get_property(InitPropProviders.ARMOR).sub_armor(BUFF_ARMOR)
