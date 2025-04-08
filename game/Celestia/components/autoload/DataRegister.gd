extends Node

var ITEMS = [
	{
		'item_name': 'Ovo de Galinha',
		'icon_name': 'chicken_egg',
		'stackable': true,
		'amount': 0,
		'type': BaseItem.item_types.consumible,
		'use': Callable(ChickenEgg, 'use_item')
	}
]
