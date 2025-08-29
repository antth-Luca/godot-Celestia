extends Control

const BASE_T_KET: String = 'celestia.ui.inventory.stats.'


func _ready() -> void:
	var title = $VBoxContainer/HBoxContainerTop/TitleLabel
	title.text = '- %s -' % CustomTranslation.t(BASE_T_KET + 'title')


func update_data_to_stats():
	var player_stats: PropertyManager = get_parent().get_parent().get_parent().entity_data.stats

	var left_column = $VBoxContainer/HBoxContainerDown/VBoxContainerLeft
	var right_column = $VBoxContainer/HBoxContainerDown/VBoxContainerRight

	# >> Column 1
	left_column.get_node('LabelHP').text = '%s: %s' % [
		CustomTranslation.t(BASE_T_KET + 'HP'),
		player_stats.get_property(InitPropProviders.HEALTH).get_format_max_health()
	]
	left_column.get_node('LabelAM').text = '%s: %s' % [
		CustomTranslation.t(BASE_T_KET + 'AM'),
		player_stats.get_property(InitPropProviders.ARMOR).get_format_armor()
	]
	left_column.get_node('LabelRS').text = '%s: %s | %s' % [
		CustomTranslation.t(BASE_T_KET + 'RS'),
		player_stats.get_property(InitPropProviders.RESISTANCE).get_format_resistance(),
		player_stats.get_property(InitPropProviders.DAMAGE_REDUCTION).get_format_damage_reduction()
	]
	left_column.get_node('LabelLS').text = '%s: %s' % [
		CustomTranslation.t(BASE_T_KET + 'LS'),
		player_stats.get_property(InitPropProviders.LIFE_STEAL).get_format_life_steal()
	]
	left_column.get_node('LabelRG').text = '%s: %s' % [
		CustomTranslation.t(BASE_T_KET + 'RG'),
		player_stats.get_property(InitPropProviders.RANGE).get_format_range()
	]
	left_column.get_node('LabelMS').text = '%s: %s' % [
		CustomTranslation.t(BASE_T_KET + 'MS'),
		player_stats.get_property(InitPropProviders.MOVE_SPEED).get_format_move_speed()
	]
	# >> Column 2
	right_column.get_node('LabelMP').text = '%s: %s' % [
		CustomTranslation.t(BASE_T_KET + 'MP'),
		player_stats.get_property(InitPropProviders.MANA).get_format_max_mana()
	]
	right_column.get_node('LabelFR').text = '%s: %s' % [
		CustomTranslation.t(BASE_T_KET + 'FR'),
		player_stats.get_property(InitPropProviders.FORCE).get_format_force()
	]
	right_column.get_node('LabelPN').text = '%s: %s | %s' % [
		CustomTranslation.t(BASE_T_KET + 'PN'),
		player_stats.get_property(InitPropProviders.PENETRATION).get_format_penetration(),
		player_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).get_format_def_reduction()
	]
	right_column.get_node('LabelCrit').text = '%s: %s | %s' % [
		CustomTranslation.t(BASE_T_KET + 'Crit'),
		player_stats.get_property(InitPropProviders.CRITICAL_STRIKE).get_format_crit_chance(),
		player_stats.get_property(InitPropProviders.CRITICAL_STRIKE).get_format_crit_damage()
	]
	right_column.get_node('LabelCdR').text = '%s: %s' % [
		CustomTranslation.t(BASE_T_KET + 'CdR'),
		player_stats.get_property(InitPropProviders.COOLDOWN_REDUCTION).get_format_cooldown_reduction()
	]
	right_column.get_node('LabelUS').text = '%s: %s' % [
		CustomTranslation.t(BASE_T_KET + 'US'),
		player_stats.get_property(InitPropProviders.USE_SPEED).get_format_use_speed()
	]
