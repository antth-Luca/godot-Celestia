extends Node2D

func _ready() -> void:
	var abstract_item = GameData.ABSTRACT_ITEM.instantiate()
	abstract_item.initialize(ItemStack.new(ChickenEgg.new(), 99))
	add_child(abstract_item)
