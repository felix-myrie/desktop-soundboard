extends PanelContainer

@export var text_box: Label
var deleting_sound: SoundEffect
signal delete_sound(sound: SoundEffect)

func request_sound_deletion(sound: SoundEffect) -> void: 
	text_box.text = "Are you sure you want to delete " + sound.display_name + "?"
	deleting_sound = sound
	visible = true
	
func confirmed_delete_sound() -> void:
	delete_sound.emit(deleting_sound)
	visible = false

func not_deleting_sound() -> void:
	visible = false
