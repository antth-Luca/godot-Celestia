extends BaseRelic
class_name PaleRoseRelic

const BUFF_CRIT_CHANCE: float = .25
const BUFF_DEF_REDUCTION: float = .12

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.RARE.get_registered()
	incompabilities = [ InitRelics.PALE_ROSE, InitRelics.ARSENAL_OF_AGES ]

# Getters and setters
func get_tooltip() -> Array[String]:
	var lines: Array[String] = super.get_tooltip()
	lines.insert(3, '[color=%s]    +%s %s\n    +%s %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		str(BUFF_CRIT_CHANCE * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'Crit%'),
		str(BUFF_DEF_REDUCTION * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'DefR')
	])
	return lines

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.CRITICAL_STRIKE).add_crit_chance(BUFF_CRIT_CHANCE)
	player_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).add_def_reduction(BUFF_DEF_REDUCTION)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.CRITICAL_STRIKE).sub_crit_chance(BUFF_CRIT_CHANCE)
	player_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).sub_def_reduction(BUFF_DEF_REDUCTION)
