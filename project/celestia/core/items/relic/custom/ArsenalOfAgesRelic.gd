extends BaseRelic
class_name ArsenalOfAgesRelic

# ClawedGlove
const BUFF_CRIT_CHANCE: float = ClawedGloveRelic.BUFF_CRIT_CHANCE + PaleRoseRelic.BUFF_CRIT_CHANCE
const BUFF_CRIT_DAMAGE: float = ClawedGloveRelic.BUFF_CRIT_DAMAGE
# PaleRose
const BUFF_DEF_REDUCTION: float = PaleRoseRelic.BUFF_DEF_REDUCTION
# WingedSocks
const BUFF_MOVE_SPEED: float = WingedSocksRelic.BUFF_MOVE_SPEED
const BUFF_MOVE_SPEED_PERCENTAGE: float = WingedSocksRelic.BUFF_MOVE_SPEED_PERCENTAGE
const BUFF_MOVE_SPEED_DURATION: float = WingedSocksRelic.BUFF_MOVE_SPEED_DURATION
const BUFF_MOVE_SPEED_COOLDOWN: float = WingedSocksRelic.BUFF_MOVE_SPEED_COOLDOWN
# CosmicFocus
const BUFF_USE_SPEED: float = CosmicFocusRelic.BUFF_USE_SPEED
const BUFF_RANGE: float = CosmicFocusRelic.BUFF_RANGE

# WingedSocks
var amount_time: float
var is_cooldown: bool = false
var is_active: bool = false
var buff_move_speed: float

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.EPIC.get_registered()
	incompabilities = [ InitRelics.ARSENAL_OF_AGES, InitRelics.CLAWED_GLOVE, InitRelics.PALE_ROSE, InitRelics.WINGED_SOCKS, InitRelics.COSMIC_FOCUS ]

# Getters and setters
func get_tooltip() -> Array[String]:
	var lines: Array[String] = super.get_tooltip()
	lines.insert(3, '[color=%s]    +%s %s\n    +%s %s\n    +%s %s\n    +%s %s\n    +%s %s\n    +%s %s\n -> %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		# ClawedGlove
		str(BUFF_CRIT_CHANCE * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'Crit%'),
		str(BUFF_CRIT_DAMAGE * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'Crit+'),
		# PaleRose
		str(BUFF_DEF_REDUCTION * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'DefR'),
		# WingedSocks
		BUFF_MOVE_SPEED, tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'MS'),
		# CosmicFocus
		str(BUFF_USE_SPEED * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'US'),
		str(BUFF_RANGE * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'RG'),
		# WingedSocks
		tr(Celestia.TRANSLATION_KEY_BASES.ITEM_DESC % InitRelics.WINGED_SOCKS.location.path)
	])
	return lines

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
