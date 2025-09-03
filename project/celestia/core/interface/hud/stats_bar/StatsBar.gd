extends Node2D
class_name StatsBar

@onready var health_bar: ProgressBar = $HealthBar
@onready var mana_bar: ProgressBar = $ManaBar
@onready var hungry_bar: ProgressBar = $HungryBar


func _on_max_health_changed(newMaxHP: float):
	health_bar.max_value = newMaxHP


func _on_health_changed(newHP: float):
	health_bar.value = newHP


func _on_max_mana_changed(newMaxMP: float):
	mana_bar.max_value = newMaxMP


func _on_mana_changed(newMP: float):
	mana_bar.value = newMP
