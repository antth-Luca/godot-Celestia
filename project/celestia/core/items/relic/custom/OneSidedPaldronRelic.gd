extends BaseRelic
class_name OneSidedPaldronRelic

# VitalCore
const BUFF_HEALTH: float = 140
const BUFF_REGENERATION: float = .3
# JadeChalice
const BUFF_RESISTANCE: float = 7
# MagmaCarapace
const IMMUNITY_DURATION: float = 30
const PULSE_DAMAGE_PERCENTAGE: float = .012
const PULSE_TICK: float = 1
# CrownOfLucidity
const BUFF_MOBILIOTY_MOD: float = .2

# JadeChalice
var soul_fragment: float
# MagmaCarapace
var amount_time: float
var amount_tick: float

# SUPER
# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	# VitalCore
	var player_hp_prop: HealthProperty = player_stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.add_max_health(BUFF_HEALTH)
	player_hp_prop.add_health(BUFF_HEALTH)
	player_stats.get_property(InitPropProviders.HEAL_MODIFIER).add_modifier(BUFF_REGENERATION)
	# JadeChalice
	player_stats.get_property(InitPropProviders.RESISTANCE).add_resistance(BUFF_RESISTANCE)
	# MagmaCarapace
	add_immunity(player)
	# CrownOfLucidity
	player_stats.get_property(InitPropProviders.MOBILITY_MODIFIER).sub_modifier(BUFF_MOBILIOTY_MOD)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	# VitalCore
	var player_hp_prop: HealthProperty = player_stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.sub_health(BUFF_HEALTH)
	player_hp_prop.sub_max_health(BUFF_HEALTH)
	player_stats.get_property(InitPropProviders.HEAL_MODIFIER).sub_modifier(BUFF_REGENERATION)
	# JadeChalice
	player_stats.get_property(InitPropProviders.RESISTANCE).sub_resistance(BUFF_RESISTANCE)
	# CrownOfLucidity
	player_stats.get_property(InitPropProviders.MOBILITY_MODIFIER).add_modifier(BUFF_MOBILIOTY_MOD)

# Hooks
#  JadeChalice
func post_hurt(_hit: HitData, _target: LivingEntity, _final_damage: float) -> void:
	if soul_fragment < .15: soul_fragment += .01


func post_heal(healed_entity: LivingEntity, _heal_value: float) -> void:
	if not soul_fragment > 0: return
	var healed_hp_prop: HealthProperty = healed_entity.entity_data.stats.get_property(InitPropProviders.HEALTH)
	var damaged_life: float = healed_hp_prop.get_max_health() - healed_hp_prop.get_health()
	if not damaged_life > 0: return
	var player := healed_entity as Player
	player.heal(damaged_life * soul_fragment, false)
	soul_fragment = 0

#  MagmaCarapace
func on_tick(equipped_entity: LivingEntity, delta: float) -> void:
	amount_time += delta
	amount_tick += delta
	if not amount_time < IMMUNITY_DURATION:
		add_immunity(equipped_entity)
		amount_time = 0
	if not amount_tick < PULSE_TICK:
		var equipped_hp_prop: HealthProperty = equipped_entity.entity_data.stats.get_property(InitPropProviders.HEALTH)
		var entities_around: Array = equipped_entity.get_tree().root.get_node('World').get_living_entites_in(equipped_entity.global_position, 20)
		for entity in entities_around:
			if entity != equipped_entity: entity.hurt(
				equipped_hp_prop.get_max_health() * PULSE_DAMAGE_PERCENTAGE,
				HitData.new(
					equipped_entity,
					HitData.PRIMITIVE_TYPE.MAGIC,
					HitData.SPECIALIZED_TYPE.NONE,
					HitData.SOURCE.SPELL,
				),
				null 
			)
		amount_tick = 0

# HANDLERS
# MagmaCarapace
func add_immunity(target_entity: LivingEntity) -> void:
	target_entity.effect_receiver.add_effect(
		EffectInstance.new(InitEffects.HEAT, IMMUNITY_DURATION)
	)
