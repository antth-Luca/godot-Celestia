extends BaseItem
class_name BaseTool

var damage_factor: float
var use_speed_factor: float
var hit_type: PackedScene = InitHits.SLASH.get_listed()

# SUPER
func _init():
	max_stack = 1


func use(player: Player, calc_use_speed: float) -> void:
	HitUtils.spawn_hit(player, InitHits.SLASH.get_listed(), calc_use_speed)
	consome_durability(1, player.inventory.get_slot(player.inventory.selected))
