extends Resource
class_name BaseEffect

@warning_ignore('unused_signal') signal effect_finished(BaseEffect)
@warning_ignore('unused_signal') signal effect_updated(BaseEffect)
@warning_ignore('unused_signal') signal effect_tick(BaseEffect)

enum EffectCategory { BENEFICIAL, NEUTRAL, MALEFICIAL }
# Common effect
var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseEffect: Item ID already set. It cannot be changed after initialization.')
		id = new_id
var category: EffectCategory
var incompabilities: Array[DeferredHolder]
var effect_timer: Timer
var amplifier: int:
	set(new_ampli):
		if not amplifier and new_ampli < 1:
			push_warning('BaseEffect: The initial amplifier value cannot be less than 1.')
		amplifier = clamp(new_ampli, 1, max_amplifier)
var max_amplifier: int:
	set(new_max):
		max_amplifier = max(new_max, 1)
# Instantaneous effects
var is_instantaneous: bool
# Per tick effects
var is_per_tick: bool
var tick_interval: float
var effect_duration: float
var max_effect_duration: float
var total_time_amount: float
var is_total_decay: bool

# GODOT
func _init(max_amplifier_param: int, init_amplifier: int, category_param: EffectCategory, instantaneous: bool, per_tick: bool, total_decay: bool, max_effect_duration_param: float, tick_interval_param: float, incompatible_effects: Array[DeferredHolder] = []) -> void:
	max_effect_duration = max_effect_duration_param
	effect_duration = max_effect_duration_param
	max_amplifier = max_amplifier_param
	amplifier = init_amplifier
	category = category_param
	is_instantaneous = instantaneous
	is_per_tick = per_tick
	tick_interval = tick_interval_param
	is_total_decay = total_decay
	incompabilities = incompatible_effects
	# Timer
	set_time(max_effect_duration_param)

# GETTERS AND SETTERS
func set_time(effect_duration_param: float) -> void:
	if not is_instantaneous:
		effect_duration = min(effect_duration_param, max_effect_duration)
		effect_timer = Timer.new()
		effect_timer.autostart = true
		effect_timer.timeout.connect(_on_effect_timer_timeout)
		if is_per_tick:
			effect_timer.wait_time = tick_interval
		else:
			effect_timer.wait_time = effect_duration

func get_hit_data() -> HitData:
	return HitData.new(
		null,
		HitData.PRIMITIVE_TYPE.MAGIC,
		HitData.SPECIALIZED_TYPE.NONE,
		HitData.SOURCE.EFFECT
	)

# MAIN
func can_add(effect_receiver: EffectReceiver) -> bool:
	for incomp in incompabilities:
		if effect_receiver.get_effect(incomp.location) != -1: return false
	return true

# HANDLERS
func _on_effect_added(_entity: LivingEntity) -> void:
	if is_instantaneous: emit_signal('effect_finished', self)


func _on_effect_renewed(_entity: LivingEntity) -> void:
	emit_signal('effect_updated', self)
	effect_timer.start()


func _on_effect_tick(_entity: LivingEntity) -> void:
	pass


func _on_effect_removed(_entity: LivingEntity) -> void:
	pass

# Timer
func _on_effect_timer_timeout() -> void:
	if is_per_tick:
		emit_signal('effect_tick', self)
		total_time_amount += tick_interval
		if total_time_amount < effect_duration:
			effect_timer.start()
		else:
			emit_signal('effect_finished', self)
			return
	else:
		if is_total_decay:
			emit_signal('effect_finished', self)
			return
		amplifier -= 1
		if amplifier > 0:
			emit_signal('effect_updated', self)
			effect_timer.start()
		else:
			emit_signal('effect_finished', self)
