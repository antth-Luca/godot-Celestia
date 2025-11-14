extends Control
class_name BossHealthBar

@onready var health_bar: ProgressBar = $Node2D/HealthBar
@onready var prev_health_bar: ProgressBar = $Node2D/HealthBar/PrevHealthBar
@onready var health_timer: Timer = $Node2D/HealthBar/HealthTimer
@onready var boss_name_label: Label = $Node2D/BossNameLabel

# EXTERNAL SIGNALS
# Health
func _on_max_health_changed(newMaxHP: float):
	health_bar.max_value = newMaxHP
	prev_health_bar.max_value = newMaxHP


func _on_health_changed(newHP: float):
	var prev_health: float = health_bar.value
	health_bar.value = newHP
	if newHP < prev_health:
		health_timer.start()
	else:
		prev_health_bar.value = newHP

# INTERNAL SIGNALS
func _on_health_timer_timeout():
	prev_health_bar.value = health_bar.value
