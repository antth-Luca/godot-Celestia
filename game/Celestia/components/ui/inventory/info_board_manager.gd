extends Control

@onready var stats_panel = $StatsPanel
@onready var container_stats_label = $StatsPanel/ScrollContainer/VBoxContainer
@onready var tooltip_panel = $TooltipPanel


func _ready() -> void:
	update_stats_labels()


func update_stats_labels() -> void:
	var player_stats = get_parent().get_parent().get_parent().stats

	container_stats_label.get_node('LabelTitle').text = CustomTr.t('ui.inventory.stats.title')
	container_stats_label.get_node('LabelHP').text = CustomTr.t('ui.inventory.stats.hp') + str(player_stats.get_max_health())
	container_stats_label.get_node('LabelMN').text = CustomTr.t('ui.inventory.stats.mn') + str(player_stats.get_max_mana())
	container_stats_label.get_node('LabelDM').text = CustomTr.t('ui.inventory.stats.dm') + str(player_stats.get_damage())
	container_stats_label.get_node('LabelDF').text = CustomTr.t('ui.inventory.stats.df') + str(player_stats.get_defense())
	container_stats_label.get_node('LabelCC').text = CustomTr.t('ui.inventory.stats.cc') + str(player_stats.get_critical_chance()) + '%'
	container_stats_label.get_node('LabelCD').text = CustomTr.t('ui.inventory.stats.cd') + str(player_stats.get_critical_damage()) + '%'
	container_stats_label.get_node('LabelLS').text = CustomTr.t('ui.inventory.stats.ls') + str(player_stats.get_life_steal()) + '%'
	container_stats_label.get_node('LabelPN').text = CustomTr.t('ui.inventory.stats.pn') + str(player_stats.get_penetration()) + '%'
	container_stats_label.get_node('LabelRG').text = CustomTr.t('ui.inventory.stats.rg') + str(player_stats.get_range())
	container_stats_label.get_node('LabelMS').text = CustomTr.t('ui.inventory.stats.ms') + str(player_stats.get_move_speed())
	container_stats_label.get_node('LabelAS').text = CustomTr.t('ui.inventory.stats.as') + str(player_stats.get_attack_speed())
	container_stats_label.get_node('LabelRC').text = CustomTr.t('ui.inventory.stats.rc') + str(player_stats.get_cooldown()) + '%'
