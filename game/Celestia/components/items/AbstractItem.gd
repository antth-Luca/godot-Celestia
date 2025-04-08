extends Sprite2D

# TODO: Remover depois, passar para singleton
var content_items = [
	{
		'item_name': 'Ovo',
		'icon_name': 'chicken_egg',
		'stackable': true,
		'amount': 0,
		'type': 1,
		'use': Callable(self, 'use_egg')
	}
]


func use_egg() -> void:
	print('Comi um ovo')


func _ready():
	set_property()


func set_property():
	texture = load("res://assets/textures/items/chicken_egg.png")


func _on_body_entered(body):
	var follow_tween = create_tween()
	follow_tween.tween_property(
		self,
		"position",
		body.global_position,
		0.1
	)
	await follow_tween.finished
	var is_add_item: bool = get_parent().find_child("Inventory").add_item_to_invent(
		BaseItem.new(
			'Ovo de Galinha',
			'chicken_egg',
			true,
			0,
			BaseItem.item_types.consumible,
			Callable(self, 'use_egg')
		), 1)
	if is_add_item: queue_free()
