extends RefCounted
class_name ItemStack

static var EMPTY = ItemStack.new(null, 0)

var _item: BaseItem
var _amount: int


func _init(item: BaseItem, amount: int = 1) -> void:
	_item = item
	_amount = amount


func get_item() -> BaseItem:
	return _item


func get_amount() -> int:
	return _amount


func set_amount(new_amount: int) -> void:
	_amount = new_amount


func add_amount_safe(amount_safe: int) -> int:
	if amount_safe <= 0: return amount_safe
	var space_left = _item.get_max_stack() - _amount
	var to_add = min(space_left, amount_safe)
	_amount += to_add
	return amount_safe - to_add


func is_empty() -> bool:
	return self == EMPTY or self.get_amount() <= 0
