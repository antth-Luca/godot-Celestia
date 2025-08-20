extends Control


func _ready() -> void:
	var title = $VBoxContainer/HBoxContainerTop/TitleLabel
	title.text = '- ' + CustomTranslation.t('celestia.ui.inventory.stats.title') + ' -'


func update_data_to_stats():
	var player_stats: PropertyManager = get_parent().get_parent().get_parent().stats

	var left_column = $VBoxContainer/HBoxContainerDown/VBoxContainerLeft
	var right_column = $VBoxContainer/HBoxContainerDown/VBoxContainerRight

	# >> Column 1
	left_column.get_node('LabelHP').text = "%s: %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.HP'),
		str(player_stats.get_property(InitPropProviders.HEALTH).get_format_max_health())
	]
	left_column.get_node('LabelAM').text = "%s: %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.AM'),
		str(player_stats.get_property(InitPropProviders.ARMOR).get_format_armor())
	]
	left_column.get_node('LabelRS').text = "%s: %s | %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.RS'),
		str(player_stats.get_property(InitPropProviders.RESISTANCE).get_format_resistance()),
		str(player_stats.get_property(InitPropProviders.DAMAGE_REDUCTION).get_format_damage_reduction()) + '%'
	]
	left_column.get_node('LabelLS').text = "%s: %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.LS'),
		str(player_stats.get_property(InitPropProviders.LIFE_STEAL).get_format_life_steal()) + '%'
	]
	left_column.get_node('LabelRG').text = "%s: %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.RG'),
		str(player_stats.get_property(InitPropProviders.RANGE).get_range())
	]
	left_column.get_node('LabelMS').text = "%s: %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.MS'),
		str(player_stats.get_property(InitPropProviders.MOVE_SPEED).get_move_speed())
	]
	# >> Column 2
	right_column.get_node('LabelMP').text = "%s: %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.MP'),
		str(player_stats.get_property(InitPropProviders.MANA).get_format_max_mana())
	]
	right_column.get_node('LabelFR').text = "%s: %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.FR'),
		str(player_stats.get_property(InitPropProviders.FORCE).get_format_force())
	]
	right_column.get_node('LabelPN').text = "%s: %s | %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.PN'),
		str(player_stats.get_property(InitPropProviders.PENETRATION).get_format_penetration()),
		str(player_stats.get_property(InitPropProviders.DEFENSE_REDUCTION).get_format_def_reduction()) + '%'
	]
	right_column.get_node('LabelCrit').text = "%s: %s | %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.Crit'),
		str(player_stats.get_property(InitPropProviders.CRITICAL_STRIKE).get_format_crit_chance()) + '%',
		str(player_stats.get_property(InitPropProviders.CRITICAL_STRIKE).get_crit_damage()) + 'x'
	]
	right_column.get_node('LabelCdR').text = "%s: %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.CdR'),
		str(player_stats.get_property(InitPropProviders.COOLDOWN_REDUCTION).get_format_cooldown_reduction()) + '%'
	]
	right_column.get_node('LabelUS').text = "%s: %s" % [
		CustomTranslation.t('celestia.ui.inventory.stats.US'),
		str(player_stats.get_property(InitPropProviders.USE_SPEED).get_use_speed())
	]
