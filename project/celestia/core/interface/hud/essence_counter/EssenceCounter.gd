extends Control

@onready var SPRITE: Sprite2D = $HBoxContainer/ArtificialHeart/Heart
@onready var ANIMATION: AnimationPlayer = $HBoxContainer/ArtificialHeart/Animation
@onready var essence_bar: ProgressBar = $HBoxContainer/ArtificialHeart/EssenceBar
@onready var prev_essence_bar: ProgressBar = $HBoxContainer/ArtificialHeart/EssenceBar/PrevEssenceBar
@onready var essence_timer: Timer = $HBoxContainer/ArtificialHeart/EssenceBar/EssenceTimer

# GODOT
func _ready() -> void:
	# Position
	var mid_coord = get_viewport_rect().size / 2
	SPRITE.position = mid_coord
	essence_bar.position = mid_coord + Vector2(20, 0)
	# Bar values
	# TODO: Preecher.

# MAIN
func show_counter() -> void:
	return


func hide_counter() -> void:
	return


func discount_essence() -> void:
	return


func heart_over() -> void:
	return
