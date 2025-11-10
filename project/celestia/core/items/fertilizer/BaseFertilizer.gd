extends BaseItem
class_name BaseFertilizer

var power: float

# SUPER
# Getters and setters
static func get_static_comparable_name() -> String:
	return 'BaseFertilizer'


func get_comparable_name() -> String:
	return BaseFertilizer.get_static_comparable_name()

# Main
func copy(copy_obj: Variant = BaseFertilizer.new()) -> Variant:
	copy_obj = super.copy(copy_obj)
	copy_obj.power = power
	return copy_obj
