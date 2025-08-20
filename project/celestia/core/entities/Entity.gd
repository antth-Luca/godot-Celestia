extends CharacterBody2D
class_name Entity

@onready var TEXTURE: Sprite2D = $Texture
@onready var ANIMATION: AnimationPlayer = $Animation

var stats: PropertyManager

var is_hurted: bool = false


func _set_state() -> void:
	pass
