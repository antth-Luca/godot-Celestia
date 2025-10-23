extends Node2D
class_name FloatingIndicator

const COLOR: Dictionary =  {
	HEAL_COLOR = Color.GREEN_YELLOW,
	PHYSIC_DAM_COLOR = Color.ORANGE_RED,
	MAGIC_DAM_COLOR = Color.MEDIUM_SLATE_BLUE,
	TRUE_DAM_COLOR = Color.FLORAL_WHITE
}

# MAIN
func initialize(value: float, hit_primitive_type: int, is_crit: bool) -> void:
	$NumberLabel.text = str(value)
	match hit_primitive_type:
		HitData.PRIMITIVE_TYPE.PHYSIC:
			self.modulate = COLOR.PHYSIC_DAM_COLOR
		HitData.PRIMITIVE_TYPE.MAGIC:
			self.modulate = COLOR.MAGIC_DAM_COLOR
		HitData.PRIMITIVE_TYPE.TRUE:
			self.modulate = COLOR.TRUE_DAM_COLOR
		_:
			self.modulate = COLOR.HEAL_COLOR
	$CriticalIcon.visible = is_crit
