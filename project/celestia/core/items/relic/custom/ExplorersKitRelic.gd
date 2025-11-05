extends BaseRelic
class_name ExplorersKitRelic

# SUPER
# Godot
func _init() -> void:
	super._init()
	rarity = InitRarities.UNCOMMON.get_registered()

# Handlers
func on_equip(slot: BaseSlot, _player: Player) -> void:
	if slot.slot_type == BaseSlot.Type.RELIC:
		print('Mini-mapa ativado!')  # TODO: Implementar mini-mapa.


func on_unequip(slot: BaseSlot, _player: Player):
	if slot.slot_type == BaseSlot.Type.RELIC:
		print('Mini-mapa desativado!')  # TODO: Implementar mini-mapa.
