extends BaseItem
class_name Egg


func _init() -> void:
	super._init(Rarity.COMMON, 12)


func use():
	print('Comi un ovo')
