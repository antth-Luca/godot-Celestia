extends Node

signal mouse_entered_slot(slot: Slot)
signal mouse_exited_slot()

signal left_click_slot(slot: Slot)
signal middle_click_slot(slot: Slot)
signal right_click_slot(slot: Slot)

signal some_pocket_slot_has_updated(slot: Slot, stack: ItemStack)
