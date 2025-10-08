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
			var weapon = FiringTool.new()
			weapon.anim_type = BaseItem.AnimType.HOLD
			weapon.ammo_item = InitAmmos.ARROW.get_registered()
			weapon.min_ammo_to_fire = 1
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
