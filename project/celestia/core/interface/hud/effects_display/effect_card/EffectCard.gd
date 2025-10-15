extends Control
class_name EffectCard

@onready var TEXTURE: Sprite2D = $Texture
@onready var label_amplifier: Label = $EffectAmplifier
@onready var progress_bar: ProgressBar = $ProgressBar

var remaining_effect_tween: Tween

# MAIN
#func initialize(effect: BaseEffect) -> void:
#	TEXTURE.texture = load(Celestia.EFFECT_SPRITE_PATH % effect.id.get_splited())
#	_on_effect_updated(effect)


func _on_effect_updated(effect: BaseEffect) -> void:
	# Label
	if effect.amplifier > 1:
		label_amplifier.text = str(effect.amplifier)
		label_amplifier.visible = true
	else:
		label_amplifier.visible = false
	# Progress bar
	# TODO: Completar aqui!
