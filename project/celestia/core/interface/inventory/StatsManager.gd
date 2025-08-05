extends Control


func _ready() -> void:
	var title = $VBoxContainer/HBoxContainerTop/TitleLabel
	title.text = '- ' + CustomTranslation.t('celestia.ui.inventory.stats.title') + ' -'


func update_data_to_stats():
	var player_stats = get_parent().get_parent().get_parent().stats

	var left_column = $VBoxContainer/HBoxContainerDown/VBoxContainerLeft
	var right_column = $VBoxContainer/HBoxContainerDown/VBoxContainerRight

	# >> Coluna 1
	left_column.get_node('LabelHP').text = CustomTranslation.t('celestia.ui.inventory.stats.hp') + str(player_stats.get_format_max_health())
	left_column.get_node('LabelAM').text = CustomTranslation.t('celestia.ui.inventory.stats.df') + str(player_stats.get_format_armor())
	left_column.get_node('LabelLS').text = CustomTranslation.t('celestia.ui.inventory.stats.ls') + str(player_stats.get_format_life_steal()) + '%'
	left_column.get_node('LabelRG').text = CustomTranslation.t('celestia.ui.inventory.stats.rg') + str(player_stats.get_range())
	left_column.get_node('LabelCritCh').text = CustomTranslation.t('celestia.ui.inventory.stats.cc') + str(player_stats.get_format_crit_chance()) + '%'
	left_column.get_node('LabelMS').text = CustomTranslation.t('celestia.ui.inventory.stats.ms') + str(player_stats.get_move_speed())
	# >> Coluna 2
	right_column.get_node('LabelMP').text = CustomTranslation.t('celestia.ui.inventory.stats.mn') + str(player_stats.get_format_max_mana())
	right_column.get_node('LabelFR').text = CustomTranslation.t('celestia.ui.inventory.stats.dm') + str(player_stats.get_format_force())
	right_column.get_node('LabelCdR').text = CustomTranslation.t('celestia.ui.inventory.stats.rc') + str(player_stats.get_format_cooldown_reduction()) + '%'
	right_column.get_node('LabelPN').text = CustomTranslation.t('celestia.ui.inventory.stats.pn') + str(player_stats.get_format_penetration()) + '%'
	right_column.get_node('LabelCritDm').text = CustomTranslation.t('celestia.ui.inventory.stats.cd') + str(player_stats.get_format_crit_damage()) + '%'
	right_column.get_node('LabelUS').text = CustomTranslation.t('celestia.ui.inventory.stats.as') + str(player_stats.get_use_speed())
