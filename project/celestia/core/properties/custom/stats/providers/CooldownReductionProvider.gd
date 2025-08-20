extends BasePropertyProvider
class_name CooldownReductionProvider

var _cd_r: CooldownReductionProperty


func create(initial_value: float) -> CooldownReductionProperty:
	if _cd_r == null:
		_cd_r = CooldownReductionProperty.new(initial_value)
	return _cd_r


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.COOLDOWN_REDUCTION:
		return _optional.call(initial_value)
	return null
