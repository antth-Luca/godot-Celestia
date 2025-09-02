extends BaseProperty
class_name StaminaProperty

signal max_stamina_changed(new_max_stamina: float)
signal stamina_changed(new_stamina: float)

var MAX_STAM: float
var stam: float
const MIN_STAM: int = 0


func _init(initial_value: float):
	set_max_stamina(initial_value)
	set_stamina(initial_value)

# Stamina
func get_stamina() -> float:
	return stam


func get_format_stamina() -> String:
	return str(int(stam))


func set_stamina(newSTAM: float) -> void:
	stam = clamp(newSTAM, MIN_STAM, MAX_STAM)
	emit_signal('stamina_changed', stam)


func add_stamina(addStam: float) -> void:
	set_stamina(stam + addStam)


func sub_stamina(subHP: float) -> void:
	set_stamina(stam - subHP)

# Max Stamina
func get_max_stamina() -> float:
	return MAX_STAM


func get_format_max_stamina() -> String:
	return str(int(MAX_STAM))


func set_max_stamina(newMaxHP: float) -> void:
	MAX_STAM = max(MIN_STAM, newMaxHP)
	emit_signal('max_stamina_changed', MAX_STAM)


func add_max_stamina(addMaxStam: float) -> void:
	set_max_stamina(MAX_STAM + addMaxStam)


func sub_max_health(subMaxHP: float) -> void:
	set_max_stamina(MAX_STAM - subMaxHP)
