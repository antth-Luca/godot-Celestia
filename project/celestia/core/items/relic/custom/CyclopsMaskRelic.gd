extends BaseRelic
class_name CyclopsMaskRelic

const BUFF_USE_SPEED: float = .2
const BUFF_LIFE_STEAL: float = .15
const HP_CEIL_TO_KILL: float = .05
const BUFF_MANA: float = 15
const BUFF_LUCK: int = 2
const BUFF_ARMOR: float = 2
const BUFF_PENETRATION: float = 2
const BUFF_MOVE_SPEED: float = 15
const BUFF_CDR: float = .35

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_mp_prop: ManaProperty = player_stats.get_property(InitPropProviders.MANA)
	player_stats.get_property(InitPropProviders.USE_SPEED).add_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.LIFE_STEAL).add_life_steal(BUFF_LIFE_STEAL)
	player_mp_prop.add_max_mana(BUFF_MANA)
	player_mp_prop.add_mana(BUFF_MANA)
	player_stats.get_property(InitPropProviders.LUCK).add_luck(BUFF_LUCK)
	player_stats.get_property(InitPropProviders.ARMOR).add_armor(BUFF_ARMOR)
	player_stats.get_property(InitPropProviders.PENETRATION).add_penetration(BUFF_PENETRATION)
	player_stats.get_property(InitPropProviders.MOVE_SPEED).add_move_speed(BUFF_MOVE_SPEED)
	player_stats.get_property(InitPropProviders.COOLDOWN_REDUCTION).add_cooldown_reduction(BUFF_CDR)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_mp_prop: ManaProperty = player_stats.get_property(InitPropProviders.MANA)
	player_stats.get_property(InitPropProviders.USE_SPEED).sub_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.LIFE_STEAL).sub_life_steal(BUFF_LIFE_STEAL)
	player_mp_prop.sub_mana(BUFF_MANA)
	player_mp_prop.sub_max_mana(BUFF_MANA)
	player_stats.get_property(InitPropProviders.LUCK).sub_luck(BUFF_LUCK)
	player_stats.get_property(InitPropProviders.ARMOR).sub_armor(BUFF_ARMOR)
	player_stats.get_property(InitPropProviders.PENETRATION).sub_penetration(BUFF_PENETRATION)
	player_stats.get_property(InitPropProviders.MOVE_SPEED).sub_move_speed(BUFF_MOVE_SPEED)
	player_stats.get_property(InitPropProviders.COOLDOWN_REDUCTION).sub_cooldown_reduction(BUFF_CDR)

# Hooks
func post_damage(hit: HitData, target: LivingEntity, _final_damage: float) -> void:
	var target_hp_prop: HealthProperty = target.entity_data.stats.get_property(InitPropProviders.HEALTH)
	var current_target_hp: float = target_hp_prop.get_health()
	if not current_target_hp > target_hp_prop.get_max_health() * HP_CEIL_TO_KILL:
		target.die(hit.attacker)
		hit.attacker.heal(current_target_hp)

# TODO: Add passiva.
