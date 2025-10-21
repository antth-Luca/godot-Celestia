extends BaseItem
class_name BaseTool

var damage_factor: float = 1
var base_lifespan: float = 1:
	set(new_base):
		base_lifespan = max(new_base, 0)
var hit_type: DeferredHolder = InitHits.SLASH

# SUPER
# Godot
func _init():
	max_stack = 1

# Getters and Setters
static func get_comparable_name() -> String:
	return 'BaseTool'

# Main
func use(player: Player) -> void:
	HitUtils.spawn_hit(player, hit_type, self)
	consume_durability(1, player.inventory.get_hand())
	set_cooldown(player)
