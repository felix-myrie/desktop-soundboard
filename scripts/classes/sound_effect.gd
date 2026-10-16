extends Resource
class_name SoundEffect

@export var display_name: String = "None"
@export var path_to_sound: String = ""
@export var emoji: String = ""

#important to use this function
func is_sound_file() -> bool:
	return true
