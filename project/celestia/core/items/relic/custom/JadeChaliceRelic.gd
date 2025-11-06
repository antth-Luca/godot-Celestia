extends BaseRelic
class_name JadeChaliceRelic

const BUFF_HEALTH: float = 20
const BUFF_RESISTANCE: float = 2

var soul_fragment: float

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.RARE.get_registered()

# Getters and setters
func get_tooltip() -> Array[String]:
	var lines: Array[String] = super.get_tooltip()
	lines.insert(3, '[color=%s]    +%s %s\n    +%s %s\n -> %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		BUFF_HEALTH, tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'HP'),
		BUFF_RESISTANCE, tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'RS'),
		tr(Celestia.TRANSLATION_KEY_BASES.ITEM_DESC % id.path)
	])
	return lines

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_hp_prop: HealthProperty = player_stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.add_max_health(BUFF_HEALTH)
	player_hp_prop.add_health(BUFF_HEALTH)
	player_stats.get_property(InitPropProviders.RESISTANCE).add_resistance(BUFF_RESISTANCE)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_hp_prop: HealthProperty = player_stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.sub_health(BUFF_HEALTH)
	player_hp_prop.sub_max_health(BUFF_HEALTH)
	player_stats.get_property(InitPropProviders.RESISTANCE).sub_resistance(BUFF_RESISTANCE)

# Hooks
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
