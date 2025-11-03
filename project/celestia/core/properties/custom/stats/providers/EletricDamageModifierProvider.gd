extends BasePropertyProvider
class_name EletricDamageModifierProvider

var _modifier: EletricDamageModifierProperty


func create(initial_value: float) -> EletricDamageModifierProperty:
	if _modifier == null:
		_modifier = EletricDamageModifierProperty.new(initial_value)
	return _modifier


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.ELETRIC_DAMAGE_MODIFIER:
		return _optional.call(initial_value)
	return null
