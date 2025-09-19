extends Node
class_name InitWeapons

static var WEAPONS: DeferredRegister
# Items
static var IRON_SWORD: DeferredHolder


static func setup() -> void:
	WEAPONS = DeferredRegister.create(
		Celestia.GAME_ID,
		ToolRegistry.REGISTRY_TYPE
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
