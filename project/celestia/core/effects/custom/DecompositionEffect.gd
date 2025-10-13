extends BaseEffect
class_name DecompositionEffect

const EFFECT_DURATION := 3.0
const TICK_INTERVAL := 1.0

# SUPER
# Godot
func _init() -> void:
	super._init(EFFECT_DURATION, TICK_INTERVAL)
