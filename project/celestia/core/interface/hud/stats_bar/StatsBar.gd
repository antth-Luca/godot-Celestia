extends Node2D
class_name StatsBar

const default_change_time: float = .4

@onready var health_bar: ProgressBar = $HealthBar
@onready var prev_health_bar: ProgressBar = $HealthBar/PrevHealthBar
@onready var health_timer: Timer = $HealthBar/HealthTimer

@onready var mana_bar: ProgressBar = $ManaBar
@onready var prev_mana_bar: ProgressBar = $ManaBar/PrevManaBar
@onready var mana_timer: Timer = $ManaBar/ManaTimer

@onready var hungry_bar: ProgressBar = $HungryBar

# GODOT
func _ready():
	health_timer.wait_time = default_change_time
	mana_timer.wait_time = default_change_time

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

# Mana
func _on_max_mana_changed(newMaxMP: float):
	mana_bar.max_value = newMaxMP
	prev_mana_bar.max_value = newMaxMP


func _on_mana_changed(newMP: float):
	var prev_mana: float = mana_bar.value
	mana_bar.value = newMP
	if newMP < prev_mana:
		mana_timer.start()
	else:
		prev_mana_bar.value = newMP

# Hungry
func _on_hungry_changed(newHungry: float):
	hungry_bar.value = newHungry

# INTERNAL SIGNALS
func _on_health_timer_timeout():
	prev_health_bar.value = health_bar.value


func _on_mana_timer_timeout():
	prev_mana_bar.value = mana_bar.value
