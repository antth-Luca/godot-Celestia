extends BaseEnchantment
class_name FreezingAirEnchantment

# SUPER
# Godot
func _init(init_level: int) -> void:
	super._init(1, init_level, [
		BaseTool.get_static_comparable_name(),
		AxeTool.get_static_comparable_name(),
		PickaxeTool.get_static_comparable_name(),
		SwordTool.get_static_comparable_name(),
		FiringTool.get_static_comparable_name()
	])

# Hooks
func post_damage(_hit: HitData, target: LivingEntity, _final_damage: float) -> void:
	target.effect_receiver.add_effect(EffectInstance.new(InitEffects.FREEZE, 2))
