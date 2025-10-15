extends GridContainer
class_name EffectsDisplay

const EFFECT_CARD_SCENE: PackedScene = preload("res://core/interface/hud/effects_display/effect_card/EffectCard.tscn")

# MAIN
func connect_signals(player_effect_receiver: EffectReceiver) -> void:
	player_effect_receiver.effect_added.connect(add_effect)
	player_effect_receiver.effect_removed.connect(remove_effect)

# GETTERS AND SETTERS
# Nodes
func get_hud() -> PlayerHUD:
	return get_parent()

# HANDLERS
func add_effect(effect: BaseEffect) -> void:
	var effect_card: EffectCard = EFFECT_CARD_SCENE.instantiate()
	effect_card.initialize(effect)
	add_child(effect_card)


func update_effect(_effect: BaseEffect) -> void:
	pass


func remove_effect(_effect: BaseEffect) -> void:
	pass
