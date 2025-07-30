extends BaseStats
class_name PlayerStats

# STATS
# Mana
var max_mp: float = 50
var mp: float = 50

# GETTERS AND SETTERS
# Mana
func get_max_mana() -> float:
	return max_mp

func get_format_max_mana() -> int:
	return ceil(max_mp)

func set_max_mana(newStat) -> void:
	if newStat <= 0: return
	max_mp = newStat

func get_mana() -> int:
	return mp

func set_mana(newStat) -> void:
	mp = clamp(newStat, 0, max_mp)

# MAIN
func _init():
	set_max_health(100)
	set_health(100)
	set_armor(0)
	set_resistence(0)
	set_force(5)
	set_range(1)
	set_use_speed(1)
	set_move_speed(80)

func _ready():
	EventBus.client_player.connect("level_up", self._on_level_up)

func _on_level_up() -> void:
	set_max_health(get_max_health() + 10)
	set_health(get_health() + 10)
	set_force(get_force() + 2.5)
	set_resistence(get_resistence() + 0.5)
	set_penetration(get_penetration() + 0.2)
