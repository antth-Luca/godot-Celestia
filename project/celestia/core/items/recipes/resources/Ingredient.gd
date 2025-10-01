extends Resource
class_name Ingredient

var item_holder: DeferredHolder
var amount: int

# GODOT
func _init(item_holder_param: DeferredHolder, amount_param: int) -> void:
	item_holder = item_holder_param
	amount = amount_param
