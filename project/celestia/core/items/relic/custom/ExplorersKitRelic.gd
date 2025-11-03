extends BaseRelic
class_name ExplorersKitRelic

# SUPER
# Handlers
func on_equip(slot: BaseSlot, _player: Player) -> void:
	if slot.slot_type == BaseSlot.Type.RELIC:
		print('Mini-mapa ativado!')  # TODO: Implementar mini-mapa.


func on_unequip(slot: BaseSlot, _player: Player):
	if slot.slot_type == BaseSlot.Type.RELIC:
		print('Mini-mapa desativado!')  # TODO: Implementar mini-mapa.
