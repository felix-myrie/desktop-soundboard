extends VBoxContainer
signal add_new_sound()
var disabled : bool = false

func _on_button_pressed() -> void:
	add_new_sound.emit()
	
	
func add_sound_action_complete() -> void:
	disabled = false
