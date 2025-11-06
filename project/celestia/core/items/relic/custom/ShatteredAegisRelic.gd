extends BaseRelic
class_name ShatteredAegisRelic

const BUFF_ARMOR: float = 5

var fragments: int

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.RARE.get_registered()

# Getters and setters
func get_tooltip() -> Array[String]:
	var lines: Array[String] = super.get_tooltip()
	lines.insert(3, '[color=%s]    +%s %s\n -> %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		BUFF_ARMOR, tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'AM'),
		tr(Celestia.TRANSLATION_KEY_BASES.ITEM_DESC % id.path)
	])
	return lines

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.ARMOR).add_armor(BUFF_ARMOR)


func on_unequip(slot: BaseSlot, player: Player):
	if slot.slot_type != BaseSlot.Type.RELIC: return
	var player_stats: PropertyManager = player.entity_data.stats
	player_stats.get_property(InitPropProviders.ARMOR).sub_armor(BUFF_ARMOR)

# Hooks
func post_hurt(_hit: HitData, _target: LivingEntity, _final_damage: float) -> void:
	if fragments < 4: fragments += 1


func override_can_apply_damage(hit: HitData, _target: LivingEntity, _final_damage: float, can_damage: bool) -> bool:
	if not fragments < 4 and hit.primitive_type != HitData.PRIMITIVE_TYPE.TRUE:
		fragments = 0
		return false
	return can_damage
