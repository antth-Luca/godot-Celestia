extends Node

@warning_ignore("unused_signal") signal mouse_entered_slot(slot: Slot)
@warning_ignore("unused_signal") signal mouse_exited_slot()

@warning_ignore("unused_signal") signal left_click_slot(slot: Slot)
@warning_ignore("unused_signal") signal middle_click_slot(slot: Slot)
@warning_ignore("unused_signal") signal right_click_slot(slot: Slot)

@warning_ignore("unused_signal") signal some_pocket_slot_has_rendered(slot_index: int, stack: ItemStack)
@warning_ignore("unused_signal") signal some_pocket_slot_has_cleaned(slot_index: int)
