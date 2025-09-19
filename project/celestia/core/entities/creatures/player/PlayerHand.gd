extends Node2D
class_name PlayerHand

@onready var ITEM_HAND_TEXTURE: Sprite2D = $ItemHandTexture
@onready var ITEM_HAND_ANIMATION: AnimationPlayer = $ItemHandAnimation

var player: Player
var is_using: bool = false
var is_interacting: bool = false
var active_interactions: Array[BaseStructure] = []
var highlighted_interaction: BaseStructure

# GODOT
func _process(_delta: float) -> void:
	if active_interactions.size() > 1:
		var nearest_interaction: BaseStructure = _get_nearest_interaction()
		if nearest_interaction != highlighted_interaction:
			highlighted_interaction.remove_highlight()
			nearest_interaction.add_highlight()
			highlighted_interaction = nearest_interaction

# GETTERS AND SETTERS
func set_item_hand_texture(item_hand: BaseItem) -> void:
	if item_hand: ITEM_HAND_TEXTURE.texture = load(Celestia.ITEM_SPRITE_PATH % item_hand.id.get_splited())

# MAIN
func perform_use() -> void:
	if is_using or is_interacting or player.is_sleeping: return
	var stack_hand: ItemStack = player.inventory.get_hand()
	if stack_hand.is_empty() or stack_hand.item.in_cooldown: return
	is_using = true
	ITEM_HAND_ANIMATION.play(stack_hand.item.anim_type)
	stack_hand.item.use(player)
	await ITEM_HAND_ANIMATION.animation_finished
	is_using = false


func perform_interact() -> void:
	if is_interacting or is_using or not highlighted_interaction or player.is_sleeping: return
	is_interacting = true
	highlighted_interaction.on_interact(player)


func register_interaction(interact: BaseStructure) -> void:
	active_interactions.push_back(interact)
	if not highlighted_interaction:
		highlighted_interaction = interact
		highlighted_interaction.add_highlight()


func unregister_interaction(interact: BaseStructure) -> void:
	var index = active_interactions.find(interact)
	if index != -1:
		active_interactions.remove_at(index)
		if highlighted_interaction == interact:
			interact.remove_highlight()
			if not active_interactions.is_empty():
				highlighted_interaction = active_interactions.front()
				highlighted_interaction.add_highlight()

# HANDLERS
func _get_nearest_interaction() -> BaseStructure:
	var nearest: Array  # [BaseStructure, float]
	var player_pos: Vector2 = player.global_position
	for interaction in active_interactions:
		var interaction_distance: float = player_pos.distance_to(interaction.global_position)
		if nearest.is_empty() or interaction_distance < nearest.back():
			nearest = [interaction, interaction_distance]
	return nearest.front()


func _ready_to_interact() -> void:
	is_interacting = false
