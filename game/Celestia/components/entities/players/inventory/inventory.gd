extends ItemList

var main_inventory = []


func _ready() -> void:
	clear_inventory()


func clear_inventory() -> void:
	var count_slots = get_child_count()
	for c in count_slots:
		main_inventory.append(ItemSlot.get_empty_slot())
	update_inventory()


func update_inventory():
	for index in main_inventory.size():
		var slot = get_child(index)
		if main_inventory[index].amount <= 0:
			main_inventory[index] = ItemSlot.get_empty_slot()
			clear_slot(slot)
			continue
		render_slot(slot, main_inventory[index])


func clear_slot(slot) -> void:
	slot.get_node('Sprite').visible = false
	slot.get_node('LabelAmount').visible = false


func render_slot(slot, item_slot: ItemSlot) -> void:
	var sprite = slot.get_node('Sprite')
	var labelAmount = slot.get_node('LabelAmount')

	sprite.texture = load("res://assets/textures/items/" + item_slot.item_class.icon_name + ".png")
	sprite.visible = true
	labelAmount.text = str(item_slot.amount)
	labelAmount.visible = item_slot.amount > 1


func has_item(item_name: String) -> bool:
	for item in main_inventory:
		if item.item_class.item_name == item_name:
			return true
	return false


func get_stackable_index(item_name: String) -> int:
	for index in main_inventory.size():
		if main_inventory[index].item_class.item_name == item_name and main_inventory[index].item_class.stackable:
			return index
	return -1


func add_item_to_invent(item_class: BaseItem, amount: int) -> bool:
	if amount < 1: return false
	if has_item(item_class.item_name) and item_class.stackable:
		main_inventory[get_stackable_index(item_class.item_name)].amount += amount
		update_inventory()
		return true
		
	for index in main_inventory.size():
		if main_inventory[index].amount <= 0:
			main_inventory[index] = ItemSlot.new(item_class, amount)
			main_inventory[index].amount = amount
			update_inventory()
			return true
	return false


func remove_item_to_invent(index: int, amount: int) -> void:
	if amount < 1: return
	main_inventory[index].amount -= amount
	update_inventory()


func _input(event):
	if event.is_action_pressed("ui_inventory"):
		visible = !visible
		if visible:
			grab_focus()
			select(0)
