extends Control
class_name EffectsDisplay

const EFFECT_CARD_SCENE: PackedScene = preload("res://core/interface/hud/effects_display/effect_card/EffectCard.tscn")

@onready var grid: GridContainer = $Node2D/GridContainer

# MAIN
func connect_signals(player_effect_receiver: EffectReceiver) -> void:
	player_effect_receiver.effect_added.connect(add_effect_card)
	player_effect_receiver.effect_removed.connect(remove_effect_card)

# GETTERS AND SETTERS
# Nodes
func get_hud() -> PlayerHUD:
	return get_parent()


func get_effect_card(effect: BaseEffect) -> EffectCard:
	return grid.get_node('%s_%s' % effect.id.get_splited())

# HANDLERS
func add_effect_card(effect: BaseEffect) -> void:
	var effect_card: EffectCard = EFFECT_CARD_SCENE.instantiate()
	effect.effect_updated.connect(update_effect_card)
	grid.add_child(effect_card)
	effect_card.initialize(effect)


func update_effect_card(effect: BaseEffect) -> void:
	var effect_card: EffectCard = get_effect_card(effect)
	if effect_card: effect_card._on_effect_updated(effect)


func remove_effect_card(effect: BaseEffect) -> void:
	var effect_card: EffectCard = get_effect_card(effect)
	if effect_card: effect_card.queue_free()
