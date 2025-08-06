extends RefCounted
class_name ItemStack

var _item: BaseItem
var _amount: int


func _init(item_class: BaseItem, amount: int = 1) -> void:
	if item_class == null:
		push_error('ItemStack must be created with an instance of BaseItem.')
	
	_item = item_class
	_amount = amount


static func get_empty_stack() -> ItemStack:
	return ItemStack.new(BaseItem.new(), 0)


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
