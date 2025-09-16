extends Control
class_name EssenceVessel

const default_change_time: float = .4

@onready var SPRITE: Sprite2D = $ArtificialHeart/Heart
@onready var ANIMATION: AnimationPlayer = $ArtificialHeart/Animation
@onready var essence_bar: ProgressBar = $ArtificialHeart/EssenceBar
@onready var prev_essence_bar: ProgressBar = $ArtificialHeart/EssenceBar/PrevEssenceBar
@onready var essence_timer: Timer = $ArtificialHeart/EssenceBar/EssenceTimer
@onready var essence_particles: CPUParticles2D = $ArtificialHeart/EssenceParticles

# GODOT
func _ready() -> void:
	# Position
	var mid_coord = get_viewport_rect().size / 2
	SPRITE.position = mid_coord
	essence_bar.position = mid_coord + Vector2(20, 0)
	essence_particles.position = mid_coord + Vector2(10, 30)
	# Timer
	essence_timer.wait_time = default_change_time
	# Visibility
	visible = false

# GETTERS AND SETTERS
# Max essence
func set_max_essence(newMax: int) -> void:
	prev_essence_bar.max_value = newMax
	essence_bar.max_value = newMax


func set_essence(newValue: int) -> void:
	prev_essence_bar.value = newValue
	essence_bar.value = newValue

# MAIN
# Animations
func refuel_essence() -> void:
	visible = true
	ANIMATION.play('entry')
	await ANIMATION.animation_finished
	await _change_essence(essence_bar.value + 1.0)
	ANIMATION.play('exit')
	await ANIMATION.animation_finished
	visible = false


func discount_essence() -> void:
	visible = true
	ANIMATION.play('entry')
	await ANIMATION.animation_finished
	ANIMATION.play('hurt')
	await ANIMATION.animation_finished
	await _change_essence(essence_bar.value - 1.0)
	ANIMATION.play('exit')
	await ANIMATION.animation_finished
	visible = false


# Bars
func _change_essence(new_essence: float) -> void:
	var prev_essence: float = essence_bar.value
	essence_bar.value = new_essence
	if new_essence < prev_essence:
		essence_timer.start()
		await essence_timer.timeout
	prev_essence_bar.value = new_essence
