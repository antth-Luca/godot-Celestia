extends BaseRelic
class_name ArsenalOfAgesRelic

# ClawedGlove
const BUFF_CRIT_CHANCE: float = .5
const BUFF_CRIT_DAMAGE: float = .4
# PaleRose
const BUFF_DEF_REDUCTION: float = .12
# WingedSocks
const BUFF_MOVE_SPEED: float = 15
const BUFF_MOVE_SPEED_PERCENTAGE: float = .4
const BUFF_MOVE_SPEED_DURATION: float = 1.5
const BUFF_MOVE_SPEED_COOLDOWN: float = 10
# CosmicFocus
const BUFF_USE_SPEED: float = .15
const BUFF_RANGE: float = .12

# WingedSocks
var amount_time: float
var is_cooldown: bool = false
var is_active: bool = false
var buff_move_speed: float

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	# ClawedGlove
	var player_crit_prop: CriticalStrikeProperty = player_stats.get_property(InitPropProviders.CRITICAL_STRIKE)
	player_crit_prop.add_crit_chance(BUFF_CRIT_CHANCE)
	player_crit_prop.add_crit_damage(BUFF_CRIT_DAMAGE)
	# PaleRose
	player_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).add_def_reduction(BUFF_DEF_REDUCTION)
	# WingedSocks
	player_stats.get_property(InitPropProviders.MOVE_SPEED).add_move_speed(BUFF_MOVE_SPEED)
	# CosmicFocus
	player_stats.get_property(InitPropProviders.USE_SPEED).add_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.RANGE).add_range(BUFF_RANGE)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	# ClawedGlove
	var player_crit_prop: CriticalStrikeProperty = player_stats.get_property(InitPropProviders.CRITICAL_STRIKE)
	player_crit_prop.sub_crit_chance(BUFF_CRIT_CHANCE)
	player_crit_prop.sub_crit_damage(BUFF_CRIT_DAMAGE)
	# PaleRose
	player_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).sub_def_reduction(BUFF_DEF_REDUCTION)
	# WingedSocks
	player_stats.get_property(InitPropProviders.MOVE_SPEED).sub_move_speed(BUFF_MOVE_SPEED)
	# CosmicFocus
	player_stats.get_property(InitPropProviders.USE_SPEED).sub_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.RANGE).sub_range(BUFF_RANGE)
	# WingedSocks passive
	if is_active: deactivate_buff_move_speed(player)

# Hooks
#  WingedSocks
func on_tick(equipped_entity: LivingEntity, delta: float) -> void:
	if is_cooldown:
		amount_time += delta
		if not amount_time < BUFF_MOVE_SPEED_COOLDOWN:
			is_cooldown = false
			amount_time = 0
	elif is_active:
		amount_time += delta
		if not amount_time < BUFF_MOVE_SPEED_DURATION:
			deactivate_buff_move_speed(equipped_entity)
			is_cooldown = true
			amount_time = 0


func post_hurt(_hit: HitData, target: LivingEntity, _final_damage: float) -> void:
	if is_cooldown or is_active: return
	activate_buff_move_speed(target)

# HANDLERS
func activate_buff_move_speed(buffed_entity: LivingEntity) -> void:
	var ms_prop: MoveSpeedProperty = buffed_entity.entity_data.stats.get_property(InitPropProviders.MOVE_SPEED)
	buff_move_speed = ms_prop.get_move_speed() * BUFF_MOVE_SPEED_PERCENTAGE
	ms_prop.add_move_speed(buff_move_speed)
	is_active = true


func deactivate_buff_move_speed(buffed_entity: LivingEntity) -> void:
	var ms_prop: MoveSpeedProperty = buffed_entity.entity_data.stats.get_property(InitPropProviders.MOVE_SPEED)
	ms_prop.sub_move_speed(buff_move_speed)
	is_active = false
