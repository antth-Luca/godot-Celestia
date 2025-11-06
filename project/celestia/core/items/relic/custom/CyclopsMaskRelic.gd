extends BaseRelic
class_name CyclopsMaskRelic

# BloodOrb
const BUFF_USE_SPEED: float = BloodOrbRelic.BUFF_USE_SPEED
const BUFF_LIFE_STEAL: float = BloodOrbRelic.BUFF_LIFE_STEAL
const HP_CEIL_TO_KILL: float = BloodOrbRelic.HP_CEIL_TO_KILL
# PerfectionistsGlove
const BUFF_MANA: float = PerfectionistsGloveRelic.BUFF_MANA
const BUFF_LUCK: int = PerfectionistsGloveRelic.BUFF_LUCK
const BUFF_ARMOR: float = PerfectionistsGloveRelic.BUFF_ARMOR + LotusBladesRelic.BUFF_ARMOR
const BUFF_DAMAGE_PERCENTAGE: float = PerfectionistsGloveRelic.BUFF_DAMAGE_PERCENTAGE
const MANA_REGEN_PERCENTAGE: float = PerfectionistsGloveRelic.MANA_REGEN_PERCENTAGE
const MANA_REGEN_COOLDOWN: float = PerfectionistsGloveRelic.MANA_REGEN_COOLDOWN
# LotusBlades
const BUFF_PENETRATION: float = LotusBladesRelic.BUFF_PENETRATION
const BLADES_DAMAGE: float = LotusBladesRelic.BLADES_DAMAGE
# HeartOfTheStorm
const BUFF_MOVE_SPEED: float = HeartOfTheStormRelic.BUFF_MOVE_SPEED
const BUFF_CDR: float = HeartOfTheStormRelic.BUFF_CDR
const BUFF_MOVE_SPEED_PERCENTAGE: float = HeartOfTheStormRelic.BUFF_MOVE_SPEED_PERCENTAGE
const BUFF_MOVE_SPEED_DURATION: float = HeartOfTheStormRelic.BUFF_MOVE_SPEED_DURATION
const BUFF_MOVE_SPEED_COOLDOWN: float = HeartOfTheStormRelic.BUFF_MOVE_SPEED_COOLDOWN
const ADD_EFFECT_DISTANCE: int = HeartOfTheStormRelic.ADD_EFFECT_DISTANCE

# PerfectionistsGlove
var last_max_mana: float
var owner_player: Player
var glove_amount_time: float
# HeartOfTheStorm
var heart_amount_time: float
var is_cooldown: bool = false
var is_active: bool = false
var buff_move_speed: float
var amount_distance: int
var is_ready_to_effect: bool = false

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.EPIC.get_registered()

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	# BloodOrb
	player_stats.get_property(InitPropProviders.USE_SPEED).add_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.LIFE_STEAL).add_life_steal(BUFF_LIFE_STEAL)
	# PerfectionistsGlove
	owner_player = player
	last_max_mana = 0
	var player_mp_prop: ManaProperty = player_stats.get_property(InitPropProviders.MANA)
	player_mp_prop.connect('max_mana_changed', Callable(self, '_on_max_mana_changed'))
	player_mp_prop.add_max_mana(BUFF_MANA)
	player_mp_prop.add_mana(BUFF_MANA)
	player_stats.get_property(InitPropProviders.LUCK).add_luck(BUFF_LUCK)
	player_stats.get_property(InitPropProviders.ARMOR).add_armor(BUFF_ARMOR)
	# LotusBlades
	player_stats.get_property(InitPropProviders.PENETRATION).add_penetration(BUFF_PENETRATION)
	# 
	player_stats.get_property(InitPropProviders.MOVE_SPEED).add_move_speed(BUFF_MOVE_SPEED)
	player_stats.get_property(InitPropProviders.COOLDOWN_REDUCTION).add_cooldown_reduction(BUFF_CDR)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	# BloodOrb
	player_stats.get_property(InitPropProviders.USE_SPEED).sub_use_speed(BUFF_USE_SPEED)
	player_stats.get_property(InitPropProviders.LIFE_STEAL).sub_life_steal(BUFF_LIFE_STEAL)
	# PerfectionistsGlove
	var player_mp_prop: ManaProperty = player_stats.get_property(InitPropProviders.MANA)
	player_mp_prop.disconnect('max_mana_changed', Callable(self, '_on_max_mana_changed'))
	remove_all_damage_buff()
	player_mp_prop.sub_mana(BUFF_MANA)
	player_mp_prop.sub_max_mana(BUFF_MANA)
	player_stats.get_property(InitPropProviders.LUCK).sub_luck(BUFF_LUCK)
	player_stats.get_property(InitPropProviders.ARMOR).sub_armor(BUFF_ARMOR)
	# LotusBlades
	player_stats.get_property(InitPropProviders.PENETRATION).sub_penetration(BUFF_PENETRATION)
	# HeartOfTheStorm
	player_stats.get_property(InitPropProviders.MOVE_SPEED).sub_move_speed(BUFF_MOVE_SPEED)
	player_stats.get_property(InitPropProviders.COOLDOWN_REDUCTION).sub_cooldown_reduction(BUFF_CDR)
	if is_active: deactivate_buff_move_speed(player)

# Hooks
func post_damage(hit: HitData, target: LivingEntity, _final_damage: float) -> void:
	#  BloodOrb
	var target_hp_prop: HealthProperty = target.entity_data.stats.get_property(InitPropProviders.HEALTH)
	var current_target_hp: float = target_hp_prop.get_health()
	if not current_target_hp > target_hp_prop.get_max_health() * HP_CEIL_TO_KILL:
		target.die(hit.attacker)
		hit.attacker.heal(current_target_hp)
	# HeartOfTheStorm
	if is_ready_to_effect:
		target.effect_receiver.add_effect(EffectInstance.new(InitEffects.STATIC))
		is_ready_to_effect = false
		amount_distance = 0
	if is_cooldown or is_active: return
	activate_buff_move_speed(hit.attacker)

#  LotusBlades
func post_hurt(_hit: HitData, target: LivingEntity, _final_damage: float) -> void:
	var entities_around: Array = target.get_tree().root.get_node('World').get_living_entites_in(target.global_position, 30)
	for entity in entities_around:
		if entity != target: entity.hurt(
			BLADES_DAMAGE,
			HitData.new(
				target,
				HitData.PRIMITIVE_TYPE.PHYSIC,
				HitData.SPECIALIZED_TYPE.PIERCE,
				HitData.SOURCE.SPELL,
				null,
				[ EffectInstance.new(InitEffects.BLEED) ]
			),
			null 
		)

func on_tick(equipped_entity: LivingEntity, delta: float) -> void:
	# PerfectionistsGlove
	glove_amount_time += delta
	if not glove_amount_time < MANA_REGEN_COOLDOWN:
		var entity_mp_prop: ManaProperty = equipped_entity.entity_data.stats.get_property(InitPropProviders.MANA)
		entity_mp_prop.add_mana(entity_mp_prop.get_max_mana() * MANA_REGEN_PERCENTAGE)
		glove_amount_time = 0
	#  HeartOfTheStorm
	if is_cooldown:
		heart_amount_time += delta
		if not heart_amount_time < BUFF_MOVE_SPEED_COOLDOWN:
			is_cooldown = false
			heart_amount_time = 0
	elif is_active:
		heart_amount_time += delta
		if not heart_amount_time < BUFF_MOVE_SPEED_DURATION:
			deactivate_buff_move_speed(equipped_entity)
			is_cooldown = true
			heart_amount_time = 0


func on_physic_tick(_equipped_entity: LivingEntity, _delta: float) -> void:
	if is_ready_to_effect: return
	amount_distance += 1
	if not amount_distance < ADD_EFFECT_DISTANCE:
		is_ready_to_effect = true

# HANDLERS
# PerfectionistsGlove
func _on_max_mana_changed(newMaxMP: float) -> void:
	if last_max_mana == newMaxMP: return
	var player_force_prop: ForceProperty = owner_player.entity_data.stats.get_property(InitPropProviders.FORCE)
	var difference: float
	if newMaxMP > last_max_mana:
		difference = newMaxMP - last_max_mana
		player_force_prop.add_force(difference * BUFF_DAMAGE_PERCENTAGE)
	else:  # newMaxMP < last_max_mana
		difference = last_max_mana - newMaxMP
		player_force_prop.sub_force(difference * BUFF_DAMAGE_PERCENTAGE)
	last_max_mana = newMaxMP


func remove_all_damage_buff() -> void:
	var player_force_prop: ForceProperty = owner_player.entity_data.stats.get_property(InitPropProviders.FORCE)
	player_force_prop.sub_force(last_max_mana * BUFF_DAMAGE_PERCENTAGE)

# HeartOfTheStorm
func activate_buff_move_speed(buffed_entity: LivingEntity) -> void:
	var ms_prop: MoveSpeedProperty = buffed_entity.entity_data.stats.get_property(InitPropProviders.MOVE_SPEED)
	buff_move_speed = ms_prop.get_move_speed() * BUFF_MOVE_SPEED_PERCENTAGE
	ms_prop.add_move_speed(buff_move_speed)
	is_active = true


func deactivate_buff_move_speed(buffed_entity: LivingEntity) -> void:
	var ms_prop: MoveSpeedProperty = buffed_entity.entity_data.stats.get_property(InitPropProviders.MOVE_SPEED)
	ms_prop.sub_move_speed(buff_move_speed)
	is_active = false
