extends BaseItem
class_name BaseTool

var damage_factor: float = 1
var base_lifespan: float = 1:
	set(new_base):
		base_lifespan = max(new_base, 0)
var hit_type: DeferredHolder = InitHits.SLASH

# SUPER
func _init():
	max_stack = 1


func use(player: Player) -> void:
	HitUtils.spawn_hit(player, hit_type, self)
	consome_durability(1, player.inventory.get_slot(player.inventory.selected))
	set_cooldown(player)
