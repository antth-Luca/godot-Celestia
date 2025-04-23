extends Control

@onready var inventory_tab = $"../InventoryTab"
@onready var stats_tab = $"../StatsTab"


func _ready():
	update_data_to_stats()
	show_inventory()


func update_data_to_stats():
	var player_stats = get_parent().get_parent().get_parent().stats
	var v_box_container = stats_tab.get_node('VBoxContainer')

	var secao1 = v_box_container.get_node('ColumnContainer')
	var coluna1A = secao1.get_node('ListContainer')
	var coluna1B = secao1.get_node('ListContainer2')

	var secao2 = v_box_container.get_node('ColumnContainer2')
	var coluna2A = secao2.get_node('ListContainer')

	# >> Coluna 1 - A
	coluna1A.get_node('LabelHP').text = CustomTr.t('ui.inventory.stats.hp') + str(player_stats.get_max_health())
	coluna1A.get_node('LabelDF').text = CustomTr.t('ui.inventory.stats.df') + str(player_stats.get_defense())
	coluna1A.get_node('LabelMS').text = CustomTr.t('ui.inventory.stats.ms') + str(player_stats.get_move_speed())
	coluna1A.get_node('LabelCC').text = CustomTr.t('ui.inventory.stats.cc') + str(player_stats.get_critical_chance()) + '%'

	# >> Coluna 1 - B
	coluna1B.get_node('LabelMN').text = CustomTr.t('ui.inventory.stats.mn') + str(player_stats.get_max_mana())
	coluna1B.get_node('LabelDM').text = CustomTr.t('ui.inventory.stats.dm') + str(player_stats.get_damage())
	coluna1B.get_node('LabelAS').text = CustomTr.t('ui.inventory.stats.as') + str(player_stats.get_attack_speed())
	coluna1B.get_node('LabelRC').text = CustomTr.t('ui.inventory.stats.rc') + str(player_stats.get_cooldown()) + '%'

	# >> Coluna 2 - A
	coluna2A.get_node('LabelPN').text = CustomTr.t('ui.inventory.stats.pn') + str(player_stats.get_penetration()) + '%'
	coluna2A.get_node('LabelLS').text = CustomTr.t('ui.inventory.stats.ls') + str(player_stats.get_life_steal()) + '%'
	coluna2A.get_node('LabelRG').text = CustomTr.t('ui.inventory.stats.rg') + str(player_stats.get_range())
	coluna2A.get_node('LabelCD').text = CustomTr.t('ui.inventory.stats.cd') + str(player_stats.get_critical_damage()) + '%'


func show_inventory():
	stats_tab.visible = false
	inventory_tab.visible = true


func show_stats():
	update_data_to_stats()
	inventory_tab.visible = false
	stats_tab.visible = true


func _on_stats_button_pressed():
	show_stats()


func _on_inventory_button_pressed():
	show_inventory()
