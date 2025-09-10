extends Node2D
class_name PlayerHand

@onready var ITEM_HAND_TEXTURE: Sprite2D = $ItemHandTexture
@onready var ITEM_HAND_ANIMATION: AnimationPlayer = $ItemHandAnimation

var player: Player
var is_using: bool = false

# GODOT
func _ready():
	ITEM_HAND_TEXTURE.show_behind_parent = true

# GETTERS AND SETTERS
func set_item_hand_texture(item_hand: BaseItem) -> void:
	if item_hand: ITEM_HAND_TEXTURE.texture = load('res://assets/%s/textures/items/%s.png' % item_hand.id.get_splited())

# SIGNALS
func _on_item_hand_animation_animation_finished(_anim_name):
	is_using = false
