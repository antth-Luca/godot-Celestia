extends Node

var registries: Dictionary = {
	RarityRegistry.REGISTRY_TYPE: RarityRegistry.new(),
	MaterialRegistry.REGISTRY_TYPE: MaterialRegistry.new(),
	ItemRegistry.REGISTRY_TYPE: ItemRegistry.new(),
	ArmorRegistry.REGISTRY_TYPE: ArmorRegistry.new()
}
