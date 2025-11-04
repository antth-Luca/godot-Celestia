extends Resource
class_name EffectInstance

var effect: DeferredHolder
var duration
var initial: int
var chance: float

# GODOT
func _init(effect_to_apply: DeferredHolder, effect_duration: float = -1, initial_amplifier: int = 1, chance_to_apply: float = 1) -> void:
	effect = effect_to_apply
	duration = effect_duration
	initial = initial_amplifier
	chance = chance_to_apply

# MAIN
func get_effect(target_entity: LivingEntity = null) -> BaseEffect:
	var instance: BaseEffect = effect.get_registered()
	instance.amplifier = initial
	if not duration < 1:
		if target_entity:
			instance.set_time(duration, target_entity)
		else:
			instance.set_time(duration)
	return instance
