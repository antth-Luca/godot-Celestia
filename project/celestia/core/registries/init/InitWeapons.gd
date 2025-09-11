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
			var weapon = BaseTool.new()
			weapon.set_durability(2)
			weapon.material = InitMaterials.IRON.get_registered()
			weapon.base_damage = 1
			weapon.anim_type = BaseItem.AnimType.USE
			return weapon
	)

	WEAPONS.register()
