extends Resource
class_name BaseEffect

@warning_ignore('unused_signal') signal effect_finished(BaseEffect)
@warning_ignore('unused_signal') signal effect_updated(BaseEffect)

enum EffectCategory { BENEFICIAL, NEUTRAL, MALEFICIAL }

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseEffect: Item ID already set. It cannot be changed after initialization.')
		id = new_id
var category: EffectCategory
var incompabilities: Array[BaseEffect]
var tick_timer: Timer
var effect_timer: Timer
var amplifier: int:
	set(new_ampli):
		if not amplifier and new_ampli < 1:
			push_warning('BaseEffect: The initial amplifier value cannot be less than 1.')
		amplifier = clamp(new_ampli, 0, max_amplifier)
		if amplifier == 0:
			emit_signal('effect_finished')
		else:
			emit_signal('effect_updated')
		if effect_timer: effect_timer.start()
var max_amplifier: int

# GODOT
func _init(effect_duration: float = 0) -> void:
	if effect_duration > 0:
		tick_timer = Timer.new()
		

# HANDLERS
func _on_effect_added(_entity: LivingEntity) -> void:
	pass


func _on_effect_tick(_entity: LivingEntity) -> void:
	pass


func _on_effect_removed(_entity: LivingEntity) -> void:
	pass

# Timer
func _on_effect_timer_timeout() -> void:
	amplifier -= 1


func _on_tick_timer_timeout() -> void:
	tick_timer.start()
