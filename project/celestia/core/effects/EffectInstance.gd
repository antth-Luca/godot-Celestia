extends Resource
class_name EffectInstance

var effect: DeferredHolder
var initial: int
var chance: float

# GODOT
func _init(effect_to_apply: DeferredHolder, initial_amplifier: int = 1, chance_to_apply: float = 1) -> void:
	effect = effect_to_apply
	initial = initial_amplifier
	chance = chance_to_apply

# MAIN
func get_effect() -> BaseEffect:
	var instance: BaseEffect = effect.get_registered()
	instance.amplifier = initial
	return instance
