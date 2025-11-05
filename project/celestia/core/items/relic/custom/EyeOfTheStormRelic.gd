extends BaseRelic
class_name EyeOfTheStormRelic

const BUFF_HEALTH: float = 60
const BUFF_ELETRIC_DAM: float = .2

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.RARE.get_registered()

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_hp_prop: HealthProperty = player_stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.add_max_health(BUFF_HEALTH)
	player_hp_prop.add_health(BUFF_HEALTH)
	player_stats.get_property(InitPropProviders.ELETRIC_DAMAGE_MODIFIER).sub_modifier(BUFF_ELETRIC_DAM)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	var player_hp_prop: HealthProperty = player_stats.get_property(InitPropProviders.HEALTH)
	player_hp_prop.sub_health(BUFF_HEALTH)
	player_hp_prop.sub_max_health(BUFF_HEALTH)
	player_stats.get_property(InitPropProviders.ELETRIC_DAMAGE_MODIFIER).add_modifier(BUFF_ELETRIC_DAM)
