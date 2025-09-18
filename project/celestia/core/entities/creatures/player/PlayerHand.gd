extends Node2D
class_name PlayerHand

@onready var ITEM_HAND_TEXTURE: Sprite2D = $ItemHandTexture
@onready var ITEM_HAND_ANIMATION: AnimationPlayer = $ItemHandAnimation

var player: Player
var is_using: bool = false
var is_interacting: bool = false
var active_interacts: Array[BaseStructure] = []
var highlighted_interact: BaseStructure  # TODO: Implementar destaque com contorno.

# GODOT
func _process(_delta: float) -> void:
	pass  # TODO: Implementar a verificação de estrutura em destaque.

# GETTERS AND SETTERS
func set_item_hand_texture(item_hand: BaseItem) -> void:
	if item_hand: ITEM_HAND_TEXTURE.texture = load(Celestia.ITEM_SPRITE_PATH % item_hand.id.get_splited())

# MAIN
func perform_use() -> void:
	if is_using or is_interacting: return
	var stack_hand: ItemStack = player.inventory.get_hand()
	if stack_hand.is_empty(): return
	is_using = true
	ITEM_HAND_ANIMATION.play(stack_hand.item.anim_type)
	stack_hand.item.use(player)
	var calc_use_speed: float = player.entity_data.stats.get_property(InitPropProviders.USE_SPEED).get_use_speed() * stack_hand.item.use_speed_factor
	await get_tree().create_timer(1 / calc_use_speed).timeout
	is_using = false


func perform_interact() -> void:
	if is_interacting or is_using: return
	is_interacting = true
	active_interacts[0].on_interact(player)
