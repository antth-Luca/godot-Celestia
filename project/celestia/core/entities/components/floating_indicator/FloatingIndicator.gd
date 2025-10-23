extends Node2D
class_name FloatingIndicator

const COLOR: Dictionary =  {
	HEAL_COLOR = Color.GREEN_YELLOW,
	PHYSIC_DAM_COLOR = Color.ORANGE_RED,
	MAGIC_DAM_COLOR = Color.MEDIUM_SLATE_BLUE,
	TRUE_DAM_COLOR = Color.FLORAL_WHITE
}

@onready var number_label = $NumberLabel
@onready var critical_icon = $CriticalIcon

# MAIN
func initialize(value: float, color: Color, is_crit: bool) -> void:
	number_label.text = str(value)
	self.modulate = color
	critical_icon.visible = is_crit
