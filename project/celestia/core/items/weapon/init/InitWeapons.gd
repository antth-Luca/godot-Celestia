extends Node
class_name InitWeapons

static var WEAPONS: DeferredRegister
# Bows
static var BOW: DeferredHolder
# Swords
static var IRON_SWORD: DeferredHolder


static func setup() -> void:
	WEAPONS = DeferredRegister.create(
		Celestia.GAME_ID,
		ItemRegistry.REGISTRY_TYPE
	)

	# Bows
	BOW = WEAPONS.add_entry(
		'bow',
		func():
			var weapon = BaseTool.new()
			weapon.anim_type = BaseItem.AnimType.HOLD
			weapon.hit_type = InitHits.ARROW
			weapon.material = InitMaterials.WOOD.get_registered()
			weapon.set_durability(1)
			return weapon
	)

	# Swords
	IRON_SWORD = WEAPONS.add_entry(
		'iron_sword',
		func():
			var weapon = SwordTool.new()
			weapon.material = InitMaterials.IRON.get_registered()
			weapon.set_durability(2)
			return weapon
	)

	WEAPONS.register()
