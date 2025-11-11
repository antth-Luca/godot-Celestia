extends RefCounted
class_name ItemStack

static var EMPTY = ItemStack.new(null)

var item: BaseItem
var amount: int


func _init(item_param: BaseItem, amount_param: int = -1) -> void:
	item = item_param
	if not item_param:
		amount = 0
	elif amount_param == -1:
		amount = item_param.max_stack
	elif amount_param < 1:
		push_warning('ItemStack: The amount cannot be less than 0.')
		amount_param = 1
	else:
		amount = min(amount_param, item_param.max_stack)


func add_amount_safe(amount_safe: int) -> int:
	if amount_safe <= 0: return amount_safe
	var space_left = item.max_stack - amount
	var to_add = min(space_left, amount_safe)
	amount += to_add
	return amount_safe - to_add


func sub_amount(sub: int, current_slot: BaseSlot) -> void:
	amount -= 1
	if not amount > 0:
		item.break_item(current_slot)
	else:
		current_slot.render_slot()


func is_empty() -> bool:
	return amount <= 0


func is_equal_to(comp_stack: ItemStack) -> bool:
	return item.id == comp_stack.item.id
