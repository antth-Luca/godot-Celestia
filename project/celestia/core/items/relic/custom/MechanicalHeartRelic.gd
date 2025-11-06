extends BaseRelic
class_name MechanicHeartRelic

const BUFF_CDR: float = .35
const BUFF_USE_SPEED: float = .1
const BUFF_MOVE_SPEED_PERCENTAGE: float = .2
const BUFF_MOVE_SPEED_DURATION: float = 3
const BUFF_MOVE_SPEED_COOLDOWN: float = 6

var amount_time: float
var is_cooldown: bool = false
var is_active: bool = false
var buff_move_speed: float

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.UNCOMMON.get_registered()
	incompabilities = [ InitRelics.MECHANICAL_HEART, InitRelics.HEART_OF_THE_STORM, InitRelics.CYCLOPS_MASK ]

# Getters and setters
func get_tooltip() -> Array[String]:
	var lines: Array[String] = super.get_tooltip()
	lines.insert(3, '[color=%s]    +%s %s\n    +%s %s\n -> %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		str(BUFF_CDR * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'CdR'),
		str(BUFF_USE_SPEED * 100) + '%', tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'US'),
		tr(Celestia.TRANSLATION_KEY_BASES.ITEM_DESC % id.path)
	])
	return lines

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.COOLDOWN_REDUCTION).add_cooldown_reduction(BUFF_CDR)
	player_stats.get_property(InitPropProviders.USE_SPEED).add_use_speed(BUFF_USE_SPEED)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.COOLDOWN_REDUCTION).sub_cooldown_reduction(BUFF_CDR)
	player_stats.get_property(InitPropProviders.USE_SPEED).sub_use_speed(BUFF_USE_SPEED)
	if is_active: deactivate_buff_move_speed(player)

# Hooks
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


func post_damage(hit: HitData, _target: LivingEntity, _final_damage: float) -> void:
	if is_cooldown or is_active: return
	activate_buff_move_speed(hit.attacker)

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
