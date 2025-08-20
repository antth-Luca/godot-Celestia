extends BasePropertyProvider
class_name LifeStealProvider

var _steal: LifeStealProperty


func create(initial_value: float) -> LifeStealProperty:
	if _steal == null:
		_steal = LifeStealProperty.new(initial_value)
	return _steal


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.LIFE_STEAL:
		return _optional.call(initial_value)
	return null
