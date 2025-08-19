extends BasePropertyProvider
class_name LifeStealProvider

var _steal: LifeStealProperty


func create() -> LifeStealProperty:
	if _steal == null:
		_steal = LifeStealProperty.new()
	return _steal


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.LIFE_STEAL:
		return _optional.call()
	return null
