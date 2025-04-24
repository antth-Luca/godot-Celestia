extends Control

@onready var full_inventory = $".."
@onready var inventory_tab = $"../InventoryTab"
@onready var stats_tab = $"../StatsTab"


func _ready():
	update_data_to_stats()
	show_inventory()


func _input(event: InputEvent) -> void:
	if full_inventory.visible:
		if event.is_action_pressed("1"):
			_on_inventory_button_pressed()
		elif event.is_action_pressed("2"):
			_on_stats_button_pressed()


func update_data_to_stats():
	var player_stats = get_parent().get_parent().get_parent().stats

	var container = stats_tab.get_node('VBoxContainer').get_node('HBoxContainer')
	var coluna1 = container.get_node('ListContainer')
	var coluna2 = container.get_node('ListContainer2')

	# >> Coluna 1
	coluna1.get_node('LabelHP').text = CustomTr.t('ui.inventory.stats.hp') + str(player_stats.get_max_health())
	coluna1.get_node('LabelDF').text = CustomTr.t('ui.inventory.stats.df') + str(player_stats.get_defense())
	coluna1.get_node('LabelLS').text = CustomTr.t('ui.inventory.stats.ls') + str(player_stats.get_life_steal()) + '%'
	coluna1.get_node('LabelRG').text = CustomTr.t('ui.inventory.stats.rg') + str(player_stats.get_range())
	coluna1.get_node('LabelCC').text = CustomTr.t('ui.inventory.stats.cc') + str(player_stats.get_critical_chance()) + '%'
	coluna1.get_node('LabelMS').text = CustomTr.t('ui.inventory.stats.ms') + str(player_stats.get_move_speed())
	# >> Coluna 2
	coluna2.get_node('LabelMN').text = CustomTr.t('ui.inventory.stats.mn') + str(player_stats.get_max_mana())
	coluna2.get_node('LabelDM').text = CustomTr.t('ui.inventory.stats.dm') + str(player_stats.get_damage())
	coluna2.get_node('LabelRC').text = CustomTr.t('ui.inventory.stats.rc') + str(player_stats.get_cooldown()) + '%'
	coluna2.get_node('LabelPN').text = CustomTr.t('ui.inventory.stats.pn') + str(player_stats.get_penetration()) + '%'
	coluna2.get_node('LabelCD').text = CustomTr.t('ui.inventory.stats.cd') + str(player_stats.get_critical_damage()) + '%'
	coluna2.get_node('LabelAS').text = CustomTr.t('ui.inventory.stats.as') + str(player_stats.get_attack_speed())


func show_inventory():
	stats_tab.visible = false
	inventory_tab.visible = true


func show_stats():
	inventory_tab.visible = false
	stats_tab.visible = true


func _on_stats_button_pressed():
	update_data_to_stats()
	show_stats()


func _on_inventory_button_pressed():
	show_inventory()
