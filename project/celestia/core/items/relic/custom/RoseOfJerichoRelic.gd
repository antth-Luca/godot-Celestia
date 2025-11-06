extends BaseRelic
class_name RoseOfJerichoRelic

const IMMUNITY_DURATION: float = 10

var amount_time: float

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.RARE.get_registered()

# Getters and setters
func get_tooltip() -> Array[String]:
	var lines: Array[String] = super.get_tooltip()
	lines.insert(3, '[color=%s] -> %s[/color]\n' % [
		COMMON_TEXT_COLOR,
		tr(Celestia.TRANSLATION_KEY_BASES.ITEM_DESC % id.path)
	])
	return lines

# Handlers
func on_equip(slot: BaseSlot, player: Player) -> void:
	if slot.slot_type != BaseSlot.Type.RELIC: return
	add_immunity(player)

# Hooks
func on_tick(equipped_entity: LivingEntity, delta: float) -> void:
	amount_time += delta
	if not amount_time < IMMUNITY_DURATION:
		add_immunity(equipped_entity)
		amount_time = 0

# HANDLERS
func add_immunity(target_entity: LivingEntity) -> void:
	target_entity.effect_receiver.add_effect(
		EffectInstance.new(InitEffects.REVITALIZE, IMMUNITY_DURATION)
	)
