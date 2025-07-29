extends Object
class_name Rarity

enum { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY }


static func get_color(rarity: Rarity) -> Color:
	match rarity:
		Rarity.COMMON:
			return Color('#F5F5F5')
		Rarity.UNCOMMON:
			return Color('#55A74E')
		Rarity.RARE:
			return Color('#4F7FD9')
		Rarity.EPIC:
			return Color('#A763C2')
		Rarity.LEGENDARY:
			return Color('#FFC300')
		_:
			return Color.WHITE


static func get_name(rarity: Rarity) -> String:
	return CustomTranslation.t("item.rarity." + str(rarity).to_lower())
