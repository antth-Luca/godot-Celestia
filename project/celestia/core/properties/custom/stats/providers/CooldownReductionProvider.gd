extends BasePropertyProvider
class_name CooldownReductionProvider

var _cd_r: CooldownReductionProperty


func create() -> CooldownReductionProperty:
	if _cd_r == null:
		_cd_r = CooldownReductionProperty.new()
	return _cd_r


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.COOLDOWN_REDUCTION:
		return _optional.call()
	return null
