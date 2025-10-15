extends Control
class_name EffectCard

@onready var TEXTURE: Sprite2D = $Texture
@onready var label_amplifier: Label = $EffectAmplifier
@onready var left_time_bar: ProgressBar = $LeftTimeBar

var remaining_effect_tween: Tween

# MAIN
func initialize(effect: BaseEffect) -> void:
	name = effect.id.get_string()
	TEXTURE.texture = load(Celestia.EFFECT_SPRITE_PATH % effect.id.get_splited())
	_on_effect_updated(effect)


func _on_effect_updated(effect: BaseEffect) -> void:
	# Label
	if effect.amplifier > 1:
		label_amplifier.text = str(effect.amplifier)
		label_amplifier.visible = true
	else:
		label_amplifier.visible = false
	# Progress bar
	var left_time_tween: Tween = create_tween()
	left_time_tween.tween_property(left_time_bar, 'value', 1, effect.effect_duration).from(0)
