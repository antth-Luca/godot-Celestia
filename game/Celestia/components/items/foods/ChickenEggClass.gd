extends BaseItem
class_name ChickenEgg


func _init() -> void:
	super._init("Ovo de Galinha", "chicken_egg", 99)


func use_item():
	print('Comi un ovo')
