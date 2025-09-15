extends BaseProperty
class_name HealthProperty

signal max_health_changed(new_max_health)
signal health_changed(new_health)
signal zero_health()

var MAX_HP: float
var hp: float
const MIN_HP: int = 0


func _init(initial_value: float):
	set_max_health(initial_value)
	set_health(initial_value)

# HP
func get_health() -> float:
	return hp


func get_format_health() -> String:
	return str(int(hp))


func set_health(newHP: float) -> void:
	hp = clamp(newHP, MIN_HP, MAX_HP)
	emit_signal('health_changed', hp)
	if hp <= 0: emit_signal('zero_health')


func add_health(addHP: float) -> void:
	set_health(hp + addHP)


func sub_health(subHP: float) -> void:
	set_health(hp - subHP)

# Max HP
func get_max_health() -> float:
	return MAX_HP


func get_format_max_health() -> String:
	return str(int(MAX_HP))


func set_max_health(newMaxHP: float) -> void:
	MAX_HP = max(MIN_HP, newMaxHP)
	emit_signal('max_health_changed', MAX_HP)


func add_max_health(addMaxHP: float) -> void:
	set_max_health(MAX_HP + addMaxHP)


func sub_max_health(subMaxHP: float) -> void:
	set_max_health(MAX_HP - subMaxHP)
