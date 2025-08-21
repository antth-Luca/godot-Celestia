extends BaseItem
class_name BaseAttributeModifierItem

var attribute_modifiers: Array[AttributeModifier]


func get_attribute_modifiers() -> Array[AttributeModifier]:
	return attribute_modifiers


func add_attribute_modifier(attribute_mod: AttributeModifier) -> void:
	attribute_modifiers.append(attribute_mod)
