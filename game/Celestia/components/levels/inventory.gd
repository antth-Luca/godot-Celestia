extends ItemList

var inventory = []


func _ready() -> void:
	clear_inventory()


func clear_inventory() -> void:
	var count_slots = get_child_count()
	for c in count_slots:
		inventory.append(BaseItem.get_empty_item())
	update_inventory()


func update_inventory():
	for index in inventory.size():
		var slot = get_child(index)
		if inventory[index].type == BaseItem.item_types.empty or inventory[index].amount <= 0:
			inventory[index] = BaseItem.get_empty_item()
			clear_slot(slot)
			continue
		render_slot(slot, inventory[index])


func clear_slot(slot) -> void:
	slot.get_node('Sprite').visible = false
	slot.get_node('LabelAmount').visible = false


func render_slot(slot, item: BaseItem) -> void:
	var sprite = slot.get_node('Sprite')
	var labelAmount = slot.get_node('LabelAmount')

	sprite.texture = load("res://assets/textures/items/" + item.icon_name + ".png")
	sprite.visible = true
	labelAmount.text = str(item.amount)
	labelAmount.visible = item.amount > 1


func has_item(name: String) -> bool:
	for item in inventory:
		if item.item_name == name:
			return true
	return false


func get_stackable_index(name: String) -> int:
	for index in inventory.size():
		if inventory[index].item_name == name and inventory[index].stackable:
			return index
	return -1


func add_item_to_invent(item: BaseItem, amount: int) -> bool:
	if amount < 1: return false
	if has_item(item.item_name) and item.stackable:
		inventory[get_stackable_index(item.item_name)].amount += amount
		update_inventory()
		return true
		
	for index in inventory.size():
		if inventory[index].type == BaseItem.item_types.empty:
			inventory[index] = item
			inventory[index].amount = amount
			update_inventory()
			return true
	return false


func remove_item_to_invent(index: int, amount: int) -> void:
	if amount < 1: return
	inventory[index].amount -= amount
	update_inventory()


func _input(event):
	if event.is_action_pressed("ui_inventory"):
		visible = !visible
		if visible:
			grab_focus()
			select(0)
