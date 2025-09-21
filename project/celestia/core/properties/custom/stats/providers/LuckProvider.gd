extends BasePropertyProvider
class_name LuckProvider

var _move: LuckProperty


func create(initial_value: float) -> LuckProperty:
	if _move == null:
		_move = LuckProperty.new(initial_value)
	return _move


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.LUCK:
		return _optional.call(initial_value)
	return null
