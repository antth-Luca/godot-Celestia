extends BaseRelic
class_name ClawedGloveRelic

const BUFF_CRIT_CHANCE: float = .25
const BUFF_CRIT_DAMAGE: float = .4

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.UNCOMMON.get_registered()

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_crit_prop: CriticalStrikeProperty = player.entity_data.stats.get_property(InitPropProviders.CRITICAL_STRIKE)
	player_crit_prop.add_crit_chance(BUFF_CRIT_CHANCE)
	player_crit_prop.add_crit_damage(BUFF_CRIT_DAMAGE)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_crit_prop: CriticalStrikeProperty = player.entity_data.stats.get_property(InitPropProviders.CRITICAL_STRIKE)
	player_crit_prop.sub_crit_chance(BUFF_CRIT_CHANCE)
	player_crit_prop.sub_crit_damage(BUFF_CRIT_DAMAGE)
