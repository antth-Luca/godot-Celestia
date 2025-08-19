extends BasePropertyProvider
class_name DamageReductionProvider

var _dam_r: DamageReductionProperty


func create() -> DamageReductionProperty:
	if _dam_r == null:
		_dam_r = DamageReductionProperty.new()
	return _dam_r


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.DAMAGE_REDUCTION:
		return _optional.call()
	return null
