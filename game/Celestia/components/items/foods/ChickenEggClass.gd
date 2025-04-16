extends BaseItem
class_name ChickenEgg


func _init() -> void:
	super._init('chicken_egg', 99)


func use_item():
	print('Comi un ovo')
