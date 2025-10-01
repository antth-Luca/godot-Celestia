extends BaseSlot
class_name EquipSlot

# SUPER
# Godot
func _ready() -> void:
	player = get_my_panel().get_parent().get_parent().player
