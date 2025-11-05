extends BaseRelic
class_name MagmaCarapaceRelic

const BUFF_HEALTH: float = 80
const IMMUNITY_DURATION: float = 30
const PULSE_DAMAGE_PERCENTAGE: float = .012
const PULSE_TICK: float = 1

var amount_time: float
var amount_tick: float

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.UNCOMMON.get_registered()

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_hp_prop: HealthProperty = player.entity_data.stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.add_max_health(BUFF_HEALTH)
	player_hp_prop.add_health(BUFF_HEALTH)
	add_immunity(player)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_hp_prop: HealthProperty = player.entity_data.stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.sub_health(BUFF_HEALTH)
	player_hp_prop.sub_max_health(BUFF_HEALTH)

# Hooks
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
func add_immunity(target_entity: LivingEntity) -> void:
	target_entity.effect_receiver.add_effect(
		EffectInstance.new(InitEffects.HEAT, IMMUNITY_DURATION)
	)
