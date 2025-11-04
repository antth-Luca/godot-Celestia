extends BasePropertyProvider
class_name MobilityModifierProvider

var _modifier: MobilityModifierProperty


func create(initial_value: float) -> MobilityModifierProperty:
	if _modifier == null:
		_modifier = MobilityModifierProperty.new(initial_value)
	return _modifier


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.MOBILITY_MODIFIER:
		return _optional.call(initial_value)
	return null
