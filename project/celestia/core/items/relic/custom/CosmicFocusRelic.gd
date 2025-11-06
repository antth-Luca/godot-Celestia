extends BaseRelic
class_name CosmicFocusRelic

const BUFF_USE_SPEED: float = .15
const BUFF_RANGE: float = .12

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.UNCOMMON.get_registered()
	incompabilities = [ InitRelics.COSMIC_FOCUS, InitRelics.ARSENAL_OF_AGES ]

# Getters and setters
func get_tooltip() -> Array[String]:
	var lines: Array[String] = super.get_tooltip()
	lines.insert(3, '[color=%s]    +%s %s\n    +%s %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		str(BUFF_USE_SPEED * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'US'),
		str(BUFF_RANGE * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'RG')
	])
	return lines

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.USE_SPEED).add_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.RANGE).add_range(BUFF_RANGE)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.USE_SPEED).sub_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.RANGE).sub_range(BUFF_RANGE)
