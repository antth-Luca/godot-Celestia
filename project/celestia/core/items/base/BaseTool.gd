extends BaseItem
class_name BaseTool

var base_damage: float

# SUPER
func _init():
	max_stack = 1


func use(player: Player) -> void:
	var targets_number: int = 1  # targets_number = player.targets.length()
	consome_durability(1 * targets_number, player.inventory.get_slot(0))
