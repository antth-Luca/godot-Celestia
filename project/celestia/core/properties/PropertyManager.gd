extends Node
class_name PropertyManager

var _providers: Dictionary[DeferredHolder, Array]


static func create_manager(stats: Dictionary[DeferredHolder, float]) -> PropertyManager:
	var manager = PropertyManager.new()
	for stat in stats:
		manager.add_provider(stat, stats[stat])
	return manager


func add_provider(prov_holder: DeferredHolder, initial_value: float) -> void:
	if not _providers.has(prov_holder):
		_providers[prov_holder] = [null, initial_value]


func get_property(holder: DeferredHolder) -> BaseProperty:
	var prov_list = _providers.get(holder)
	if prov_list != null and prov_list[0] == null:
		prov_list[0] = holder.get_registered()
	var prov: BasePropertyProvider = prov_list[0]
	return prov.get_property(holder, prov_list[1])
