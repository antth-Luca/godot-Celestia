extends BaseItem
class_name BaseTool

var damage_factor: float = 1
var use_speed_factor: float = 1
var range_factor: float = 1
var hit_type: PackedScene = InitHits.SLASH.get_listed()

# SUPER
func _init():
	max_stack = 1


func use(player: Player) -> void:
	HitUtils.spawn_hit(player, InitHits.SLASH.get_listed(), range_factor, damage_factor)
	consome_durability(1, player.inventory.get_slot(player.inventory.selected))
