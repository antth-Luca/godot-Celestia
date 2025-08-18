extends Node
class_name InitMaterials

static var MATERIALS: DeferredRegister
# Materials
static var GENERIC: DeferredHolder
static var WOOD: DeferredHolder
static var STONE: DeferredHolder
static var FULGURITE: DeferredHolder
static var COPPER: DeferredHolder
static var ERUPTITE: DeferredHolder
static var CARNIGO: DeferredHolder
static var IRON: DeferredHolder
static var DARK_IRON: DeferredHolder
static var ASTRONITE: DeferredHolder
static var LUNATITE: DeferredHolder
static var CELESTITE: DeferredHolder


func _ready() -> void:
	MATERIALS = DeferredRegister.create(
		Celestia.GAME_ID,
		MaterialRegistry.REGISTRY_TYPE
	)

	# Materials
	GENERIC = MATERIALS.add_entry(
		'generic',
		func():
			return BaseMaterial.new()
	)

	WOOD = MATERIALS.add_entry(
		'wood',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(32)
			material.set_efficiency(0)
			return material
	)

	STONE = MATERIALS.add_entry(
		'stone',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(48)
			material.set_efficiency(1)
			return material
	)

	FULGURITE = MATERIALS.add_entry(
		'fulgurite',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(58)
			return material
	)

	COPPER = MATERIALS.add_entry(
		'copper',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(65)
			material.set_efficiency(2)
			return material
	)

	ERUPTITE = MATERIALS.add_entry(
		'eruptite',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(74)
			material.set_efficiency(2)
			return material
	)

	MATERIALS.add_entry(
		'carnigo',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(90)
			material.set_efficiency(2)
			return material
	)

	IRON = MATERIALS.add_entry(
		'iron',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(112)
			material.set_efficiency(3)
			return material
	)

	DARK_IRON = MATERIALS.add_entry(
		'dark_iron',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(122)
			material.set_efficiency(3)
			return material
	)

	ASTRONITE = MATERIALS.add_entry(
		'astronite',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(160)
			material.set_efficiency(4)
			return material
	)

	MATERIALS.add_entry(
		'lunatite',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(208)
			material.set_efficiency(5)
			return material
	)

	CELESTITE = MATERIALS.add_entry(
		'celestite',
		func():
			var material = BaseMaterial.new()
			material.set_base_max_damage(272)
			material.set_efficiency(6)
			return material
	)
