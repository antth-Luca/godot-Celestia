extends Control

@onready var stats_panel = $StatsPanel
@onready var container_stats_label = $StatsPanel/ScrollContainer/VBoxContainer


func _ready() -> void:
	update_stats_labels()


func update_stats_labels() -> void:
	var player_stats = get_parent().get_parent().get_parent().stats

	container_stats_label.get_child(0).text = CustomTr.t('ui.inventory.stats.title')
	container_stats_label.get_child(1).text = CustomTr.t('ui.inventory.stats.hp') + str(player_stats.get_max_health())
	container_stats_label.get_child(2).text = CustomTr.t('ui.inventory.stats.mn') + str(player_stats.get_max_mana())
	container_stats_label.get_child(3).text = CustomTr.t('ui.inventory.stats.dm') + str(player_stats.get_damage())
	container_stats_label.get_child(4).text = CustomTr.t('ui.inventory.stats.df') + str(player_stats.get_defense())
	container_stats_label.get_child(5).text = CustomTr.t('ui.inventory.stats.cc') + str(player_stats.get_critical_chance()) + '%'
	container_stats_label.get_child(6).text = CustomTr.t('ui.inventory.stats.cd') + str(player_stats.get_critical_damage()) + '%'
	container_stats_label.get_child(7).text = CustomTr.t('ui.inventory.stats.ls') + str(player_stats.get_life_steal()) + '%'
	container_stats_label.get_child(8).text = CustomTr.t('ui.inventory.stats.pn') + str(player_stats.get_penetration()) + '%'
	container_stats_label.get_child(9).text = CustomTr.t('ui.inventory.stats.rg') + str(player_stats.get_range())
	container_stats_label.get_child(10).text = CustomTr.t('ui.inventory.stats.ms') + str(player_stats.get_move_speed())
	container_stats_label.get_child(11).text = CustomTr.t('ui.inventory.stats.as') + str(player_stats.get_attack_speed())
	container_stats_label.get_child(12).text = CustomTr.t('ui.inventory.stats.rc') + str(player_stats.get_cooldown()) + '%'
