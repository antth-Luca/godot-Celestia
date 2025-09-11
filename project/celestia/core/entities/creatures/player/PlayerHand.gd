extends Node2D
class_name PlayerHand

@onready var ITEM_HAND_TEXTURE: Sprite2D = $ItemHandTexture
@onready var ITEM_HAND_ANIMATION: AnimationPlayer = $ItemHandAnimation

var player: Player
var is_using: bool = false

# GETTERS AND SETTERS
func set_item_hand_texture(item_hand: BaseItem) -> void:
	if item_hand: ITEM_HAND_TEXTURE.texture = load('res://assets/%s/textures/items/%s.png' % item_hand.id.get_splited())

# SIGNALS
func _on_item_hand_animation_animation_finished(_anim_name):
	is_using = false

# MAIN
func perform_use() -> void:
	var stack_hand: ItemStack = player.inventory.get_hand()
	if stack_hand.is_empty(): return
	is_using = true
	stack_hand.item.use(player)
	ITEM_HAND_ANIMATION.play(stack_hand.item.anim_type)
