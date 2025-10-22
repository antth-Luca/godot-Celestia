extends BaseItem
class_name BaseFood

var satiation: float = 1:
	set(new_sat):
		satiation = max(new_sat, 0)
var always_eat: bool = false
var regen_hp: float = 0:
	set(new_regen):
		regen_hp = max(new_regen, 0)
var effects_list: Array[EffectInstance]

# SUPER
# Getters and Setters
static func get_static_comparable_name() -> String:
	return 'BaseFood'


func get_comparable_name() -> String:
	return BaseFood.get_static_comparable_name()


func get_tooltip() -> Array[String]:
	var when_line = '[color=%s]%s:\n' % [
		COMMON_TEXT_COLOR,
		tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'when_use')
	]
	if satiation != 0:
		when_line += '  %s %s\n' % [
			satiation, tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'satiation')
		]
	if regen_hp != 0:
		when_line += '  %s %s\n' % [
			regen_hp, tr(Celestia.TRANSLATION_KEY_BASES.STATS % 'HP')
		]
	if not effects_list.is_empty():
		for instance in effects_list:
			var effect: BaseEffect = instance.get_effect()
			when_line += '  %s [%s%s]\n' % [
			tr(Celestia.TRANSLATION_KEY_BASES.EFFECT % effect.id.path),
			int(effect.effect_duration), tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'seconds')
		]
	when_line += '[/color]'
	var lines = super.get_tooltip()
	lines.append(when_line)
	return lines

# Main
func copy(copy_obj: Variant = BaseFood.new()) -> Variant:
	copy_obj = super.copy(copy_obj)
	copy_obj.satiation = satiation
	copy_obj.always_eat = always_eat
	copy_obj.regen_hp = regen_hp
	copy_obj.effects_list = effects_list.duplicate(true)
	return copy_obj

# Handlers
func use(player: Player) -> void:
	var hungry_prop: HungryProperty = player.entity_data.stats.get_property(InitPropProviders.HUNGRY)
	if always_eat or hungry_prop.get_hungry() < hungry_prop.get_max_hungry():
		hungry_prop.add_hungry(satiation)
		if regen_hp > 0: player.heal(regen_hp)
		var hand_slot: BaseSlot = player.inventory.get_hand()
		var stack: ItemStack = hand_slot.stack
		stack.amount -= 1
		if stack.amount <= 0:
			break_item(hand_slot)
		else:
			hand_slot.render_slot()
		for effect_instance in effects_list:
			player.effect_receiver.add_effect(effect_instance)
