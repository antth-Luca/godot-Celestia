extends Object
class_name BaseItem

var max_stack: int
var rarity: int

func _init(num_stack: int, enum_rarity: int) -> void:
	self.max_stack = num_stack
	self.rarity = enum_rarity


static func get_empty_item() -> BaseItem:
	return BaseItem.new(Rarity.COMMON, 1)
