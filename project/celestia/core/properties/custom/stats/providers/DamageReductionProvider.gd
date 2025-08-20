extends BasePropertyProvider
class_name DamageReductionProvider

var _dam_r: DamageReductionProperty


func create(initial_value: float) -> DamageReductionProperty:
	if _dam_r == null:
		_dam_r = DamageReductionProperty.new(initial_value)
	return _dam_r


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.DAMAGE_REDUCTION:
		return _optional.call(initial_value)
	return null
