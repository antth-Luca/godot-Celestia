extends Object
class_name Rarity

enum { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY }


static func get_color(rarity_key: int) -> String:
	match rarity_key:
		COMMON:
			return '#D5D5D5'
		UNCOMMON:
			return '#55A74E'
		RARE:
			return '#4F7FD9'
		EPIC:
			return '#A763C2'
		LEGENDARY:
			return '#FFC300'
		_:
			return '#FFFFFF'


static func get_tr_name(rarity_key: int) -> String:
	var rarity_id
	match rarity_key:
		COMMON:
			rarity_id = 'common'
		UNCOMMON:
			rarity_id = 'uncommon'
		RARE:
			rarity_id = 'rare'
		EPIC:
			rarity_id = 'epic'
		LEGENDARY:
			rarity_id = 'legendary'
	return CustomTranslation.t('celestia.item.rarity.%s' % [rarity_id])
