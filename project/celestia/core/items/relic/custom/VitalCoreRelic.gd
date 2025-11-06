extends BaseRelic
class_name VitalCoreRelic

const BUFF_HEALTH: float = 40
const BUFF_REGENERATION: float = .3

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.RARE.get_registered()
	incompabilities = [ InitRelics.VITAL_CORE, InitRelics.ONE_SIDED_PALDRON ]

# Getters and setters
func get_tooltip() -> Array[String]:
	var lines: Array[String] = super.get_tooltip()
	lines.insert(3, '[color=%s]    +%s %s\n    +%s %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		BUFF_HEALTH, tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'HP'),
		str(BUFF_REGENERATION * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'Regen')
	])
	return lines

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_hp_prop: HealthProperty = player_stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.add_max_health(BUFF_HEALTH)
	player_hp_prop.add_health(BUFF_HEALTH)
	player_stats.get_property(InitPropProviders.HEAL_MODIFIER).add_modifier(BUFF_REGENERATION)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_hp_prop: HealthProperty = player_stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.sub_health(BUFF_HEALTH)
	player_hp_prop.sub_max_health(BUFF_HEALTH)
	player_stats.get_property(InitPropProviders.HEAL_MODIFIER).sub_modifier(BUFF_REGENERATION)
