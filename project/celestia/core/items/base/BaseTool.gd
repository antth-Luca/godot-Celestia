extends BaseItem
class_name BaseTool

enum AnimType { CONICAL, MELEE_LINE, RANGE_AREA, PROJECTILE }

var anim_type: AnimType
var base_damage: float

# SUPER
func _init():
	max_stack = 1


func use(player: Player) -> void:
	var targets_number: int = player.perform_attack(self)
	consome_durability(1 * targets_number, player.get_ui().get_invent_panel().get_inventory_tab().get_slot(0))
