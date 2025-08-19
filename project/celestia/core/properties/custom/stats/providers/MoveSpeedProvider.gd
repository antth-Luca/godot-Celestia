extends BasePropertyProvider
class_name MoveSpeedProvider

var _move: MoveSpeedProperty


func create() -> MoveSpeedProperty:
	if _move == null:
		_move = MoveSpeedProperty.new()
	return _move


func get_property(prop: DeferredHolder):
	if prop == InitPropProviders.MOVE_SPEED:
		return _optional.call()
	return null
