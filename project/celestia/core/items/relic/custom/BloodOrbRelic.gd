extends BaseRelic
class_name BloodOrbRelic

const BUFF_USE_SPEED: float = .10
const BUFF_LIFE_STEAL: float = .15
const HP_CEIL_TO_KILL: float = .05

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.USE_SPEED).add_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.LIFE_STEAL).add_life_steal(BUFF_LIFE_STEAL)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.USE_SPEED).sub_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.LIFE_STEAL).sub_life_steal(BUFF_LIFE_STEAL)

# Hooks
func post_damage(hit: HitData, target: LivingEntity, _final_damage: float) -> void:
	var target_hp_prop: HealthProperty = target.entity_data.stats.get_property(InitPropProviders.HEALTH)
	var current_target_hp: float = target_hp_prop.get_health()
	if not current_target_hp > target_hp_prop.get_max_health() * HP_CEIL_TO_KILL:
		target.die(hit.attacker)
		hit.attacker.heal(current_target_hp)
