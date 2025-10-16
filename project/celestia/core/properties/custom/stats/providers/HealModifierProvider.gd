extends BasePropertyProvider
class_name HealModifierProvider

var _modifier: HealModifierProperty


func create(initial_value: float) -> HealModifierProperty:
	if _modifier == null:
		_modifier = HealModifierProperty.new(initial_value)
	return _modifier


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.HEAL_MODIFIER:
		return _optional.call(initial_value)
	return null
