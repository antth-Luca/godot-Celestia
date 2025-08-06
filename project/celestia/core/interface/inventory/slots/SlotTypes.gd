extends Object
class_name SlotTypes

enum { GENERIC, HEAD, CHESTPLATE, LEGS, FEET, RELIC, AMMO }


static func get_id(type_key: int) -> String:
	var id = Celestia.GAME_ID + ":"
	match type_key:
		GENERIC:
			id += 'generic'
		HEAD:
			id += 'head'
		CHESTPLATE:
			id += 'chestplate'
		LEGS:
			id += 'legs'
		FEET:
			id += 'feet'
		RELIC:
			id += 'relic'
		AMMO:
			id += 'ammo'
	return id


static func get_splited_id(type_key: int) -> Array:
	var splited_id := [ Celestia.GAME_ID ]
	match type_key:
		GENERIC:
			splited_id.append('generic')
		HEAD:
			splited_id.append('head')
		CHESTPLATE:
			splited_id.append('chestplate')
		LEGS:
			splited_id.append('legs')
		FEET:
			splited_id.append('feet')
		RELIC:
			splited_id.append('relic')
		AMMO:
			splited_id.append('ammo')
	return splited_id
