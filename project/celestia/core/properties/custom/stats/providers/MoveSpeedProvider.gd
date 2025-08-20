extends BasePropertyProvider
class_name MoveSpeedProvider

var _move: MoveSpeedProperty


func create(initial_value: float) -> MoveSpeedProperty:
	if _move == null:
		_move = MoveSpeedProperty.new(initial_value)
	return _move


func get_property(prop: DeferredHolder, initial_value: float):
	if prop == InitPropProviders.MOVE_SPEED:
		return _optional.call(initial_value)
	return null
