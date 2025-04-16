extends Node
class_name BaseItem

var item_key: String
var max_stack: int

func _init(key: String, num_stack: int) -> void:
	self.item_key = key
	self.max_stack = num_stack


static func get_empty_item() -> BaseItem:
	return BaseItem.new('', 99)
