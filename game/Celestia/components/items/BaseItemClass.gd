extends Node
class_name BaseItem

var item_name: String
var icon_name: String
var stackable: bool

func _init(item: String, icon: String, is_stackable: bool) -> void:
	self.item_name = item
	self.icon_name = icon
	self.stackable = is_stackable


static func get_empty_item() -> BaseItem:
	return BaseItem.new('', '', false)
