extends Node
class_name EffectReceiver

var entity: LivingEntity
var active_effects: Array[BaseEffect]

# GODOT
func _init(parent_entity: LivingEntity) -> void:
	entity = parent_entity


# MAIN
func add_effect(effect: BaseEffect) -> void:
	if not effect: return
	active_effects.append(effect)
	effect.connect('effect_finished', Callable(self, 'remove_effect'))
	if effect.effect_timer: add_child(effect.effect_timer)
	if effect.tick_timer: add_child(effect.tick_timer)
	effect._on_effect_added(entity)


func remove_effect(effect: BaseEffect) -> void:
	var pos: int = active_effects.find(effect)
	if pos < 0: return
	active_effects[pos]._on_effect_removed(entity)
	active_effects.remove_at(pos)
