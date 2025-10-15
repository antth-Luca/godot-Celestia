extends Control
class_name EffectsDisplay

const EFFECT_CARD_SCENE: PackedScene = preload("res://core/interface/hud/effects_display/effect_card/EffectCard.tscn")

@onready var grid: GridContainer = $Node2D/GridContainer

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
	grid.add_child(effect_card)
	effect_card.initialize(effect)


func update_effect(_effect: BaseEffect) -> void:
	pass


func remove_effect(effect: BaseEffect) -> void:
	var effect_card: EffectCard = grid.get_node('%s_%s' % effect.id.get_splited())
	if effect_card: effect_card.queue_free()
