extends BaseItem
class_name BaseTool

var base_damage: float

# SUPER
func _init():
	max_stack = 1


func use(player: Player) -> void:
	consome_durability(1, player.inventory.get_slot(0))
