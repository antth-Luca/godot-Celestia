extends BaseRelic
class_name LotusBladesRelic

const BUFF_ARMOR: float = 1
const BUFF_PENETRATION: float = 6
const BLADES_DAMAGE: float = 10

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.RARE.get_registered()

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.ARMOR).add_armor(BUFF_ARMOR)
	player_stats.get_property(InitPropProviders.PENETRATION).add_penetration(BUFF_PENETRATION)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.ARMOR).sub_armor(BUFF_ARMOR)
	player_stats.get_property(InitPropProviders.PENETRATION).sub_penetration(BUFF_PENETRATION)

# Hooks
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
