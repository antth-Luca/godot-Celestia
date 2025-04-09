extends Sprite2D

@export var item_id: int
@export var amount_item: int


func _ready():
	texture = load("res://assets/textures/items/" + DataRegister.ITEMS[item_id].icon_name + ".png")


func _on_body_entered(body):
	if body.is_in_group("player"):
		var follow_tween = create_tween()
		follow_tween.tween_property(
			self,
			"position",
			body.global_position + Vector2(-8, 8),
			0.1
		)
		await follow_tween.finished
		var data_item = DataRegister.ITEMS[item_id]
		var is_add_item: bool = get_parent().find_child("BackpackSlots").add_item_to_invent(
			BaseItem.new(
				data_item.item_name,
				data_item.icon_name,
				data_item.stackable
			), amount_item)
		if is_add_item: queue_free()
