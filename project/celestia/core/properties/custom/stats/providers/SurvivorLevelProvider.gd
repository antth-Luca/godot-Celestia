extends BasePropertyProvider
class_name SurvivorLevelProvider

var _surv_level: SurvivorLevelProperty


func create(initial_value: int) -> SurvivorLevelProperty:
	if _surv_level == null:
		_surv_level = SurvivorLevelProperty.new(initial_value)
	return _surv_level


func get_property(prop: DeferredHolder, initial_value: int):
	if prop == InitPropProviders.SURVIVOR_LEVEL:
		return _optional.call(initial_value)
	return null
