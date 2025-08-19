extends RefCounted
class_name BasePropertyProvider

var _optional := Callable(self, "create")


func create() -> BaseProperty:
	return null


func get_property(prop: DeferredHolder):
	pass
