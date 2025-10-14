extends Node
class_name EffectReceiver


@warning_ignore('unused_signal') signal effect_added(effect: BaseEffect)
@warning_ignore('unused_signal') signal effect_removed(effect: BaseEffect)

@export var entity: LivingEntity

var active_effects: Array[BaseEffect]

# GODOT
func _process(_delta: float) -> void:
	for effect in active_effects:
		effect._on_effect_tick(entity)


# MAIN
func add_effect(effect: BaseEffect) -> void:
	if not effect: return
	var pos: int = active_effects.find(effect)
	if pos < 0:
		if effect.can_add(active_effects):
			active_effects.append(effect)
			effect.effect_finished.connect(remove_effect)
			effect._on_effect_added(entity)
			emit_signal('effect_added', effect)
			add_child(effect.effect_timer)
			for incomp in effect.incompabilities:
				remove_effect(incomp)
	else:
		active_effects[pos]._on_effect_renewed(entity)


func remove_effect(effect: BaseEffect) -> void:
	var pos: int = active_effects.find(effect)
	if pos < 0: return
	var active: BaseEffect = active_effects[pos]
	active._on_effect_removed(entity)
	if active.effect_timer: active.effect_timer.queue_free()
	emit_signal('effect_removed', active)
	active_effects.remove_at(pos)
