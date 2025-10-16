extends Node
class_name EffectReceiver


@warning_ignore('unused_signal') signal effect_added(effect: BaseEffect)
@warning_ignore('unused_signal') signal effect_removed(effect: BaseEffect)

@export var entity: LivingEntity

var active_effects: Array[BaseEffect]

# GODOT
func _ready() -> void:
	if not entity is Player: return
	var effects_display: EffectsDisplay = entity.get_ui().get_hud().get_effects_display()
	effects_display.connect_signals(self)

# MAIN
func get_effect(effect_id: ResourceLocation) -> int:
	for c in active_effects.size():
		if active_effects[c].id.get_string() == effect_id.get_string():
			return c
	return -1


func add_effect(effect_instance: EffectInstance) -> void:
	if not effect_instance: return
	if effect_instance.chance != 1 and randf() > effect_instance.chance: return
	var pos: int = get_effect(effect_instance.effect.location)
	if pos < 0:
		var effect: BaseEffect = effect_instance.get_effect()
		if effect.can_add(self):
			active_effects.append(effect)
			effect.effect_finished.connect(remove_effect)
			effect._on_effect_added(entity)
			emit_signal('effect_added', effect)
			if effect.effect_timer:
				add_child(effect.effect_timer)
				if effect.is_per_tick:
					effect.effect_tick.connect(tick_effect)
			for incomp in effect.incompabilities:
				remove_effect(incomp.get_registered())
	else:
		active_effects[pos]._on_effect_renewed(entity)


func remove_effect(effect: BaseEffect) -> void:
	var pos: int = get_effect(effect.id)
	if pos < 0: return
	var active: BaseEffect = active_effects[pos]
	active._on_effect_removed(entity)
	if active.effect_timer: active.effect_timer.queue_free()
	emit_signal('effect_removed', active)
	active_effects.remove_at(pos)


func tick_effect(effect: BaseEffect) -> void:
	effect._on_effect_tick(entity)
