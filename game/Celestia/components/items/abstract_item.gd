extends Sprite2D

var stack: ItemStack
var can_be_picked_up = false

@onready var pickup_timer: Timer = Timer.new()


func _ready():
	# Configura o Timer e adiciona como filho do item
	pickup_timer.wait_time = 1
	pickup_timer.one_shot = true
	pickup_timer.connect("timeout", Callable(self, "_on_pickup_timer_timeout"))
	add_child(pickup_timer)
	pickup_timer.start()


func initialize(stack_param: ItemStack):
	self.stack = stack_param
	texture = load("res://assets/textures/items/" + stack.item_class.item_key + ".png")


func _on_pickup_timer_timeout():
	can_be_picked_up = true


func _on_body_entered(body):
	if !can_be_picked_up: return

	if body.is_in_group("player"):
		var inventory = body.get_node("UI/FullInventory")
		if !inventory.is_full():
			var follow_tween = create_tween()
			follow_tween.tween_property(
				self,
				"position",
				body.global_position,
				0.1
			)
			await follow_tween.finished
			inventory.add_item_to_backpack(stack)
			queue_free()
		else:
			can_be_picked_up = false
			pickup_timer.start()
