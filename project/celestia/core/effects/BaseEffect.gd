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
var effect_timer: Timer
var tick_interval: float
var is_instantaneous: bool
var is_total_decay: bool
var amplifier: int:
	set(new_ampli):
		if new_ampli < 1:
			push_warning('BaseEffect: The initial amplifier value cannot be less than 1.')
		amplifier = clamp(new_ampli, 1, max_amplifier)
var max_amplifier: int:
	set(new_max):
		max_amplifier = max(new_max, 1)

# GODOT
func _init(max_amplifier_param: int, init_amplifier: int, instantaneous: bool = false, total_decay: bool = true, effect_duration: float = 0, tick_interval_param: float = 0, incompatible_effects: Array[BaseEffect] = []) -> void:
	max_amplifier = max_amplifier_param
	amplifier = init_amplifier
	is_instantaneous = instantaneous
	is_total_decay = total_decay
	if not is_instantaneous and effect_duration > 0:
		effect_timer = Timer.new()
		effect_timer.autostart = true
		effect_timer.wait_time = effect_duration
		effect_timer.timeout.connect(_on_effect_timer_timeout)
	if tick_interval_param != 0:
		tick_interval = tick_interval_param
	incompabilities = incompatible_effects

# HANDLERS
func _on_effect_added(_entity: LivingEntity) -> void:
	if is_instantaneous: emit_signal('effect_finished', self)


func _on_effect_renewed(_entity: LivingEntity) -> void:
	pass


func _on_effect_tick(_entity: LivingEntity) -> void:
	if fmod(effect_timer.time_left, tick_interval) != 0: return
	pass


func _on_effect_removed(_entity: LivingEntity) -> void:
	pass

# Timer
func _on_effect_timer_timeout() -> void:
	if is_total_decay: emit_signal('effect_finished', self)
	amplifier -= 1
	if amplifier == 0:
		emit_signal('effect_finished', self)
	else:
		emit_signal('effect_updated', self)
	effect_timer.start()
