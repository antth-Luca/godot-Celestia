extends Node
class_name BaseItem

var item_name: String
var icon_name: String
var max_stack: int

func _init(item: String, icon: String, num_stack: int) -> void:
	self.item_name = item
	self.icon_name = icon
	self.max_stack = num_stack


static func get_empty_item() -> BaseItem:
	return BaseItem.new('', '', 99)
