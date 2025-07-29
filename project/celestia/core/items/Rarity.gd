extends Object
class_name Rarity

enum { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY }


static func get_color(rarity: Rarity) -> Color:
	match rarity:
		COMMON:
			return Color('#F5F5F5')
		UNCOMMON:
			return Color('#55A74E')
		RARE:
			return Color('#4F7FD9')
		EPIC:
			return Color('#A763C2')
		LEGENDARY:
			return Color('#FFC300')
		_:
			return Color.WHITE


static func get_name(rarity: Rarity) -> String:
	return CustomTranslation.t("item.rarity." + str(rarity).to_lower())
