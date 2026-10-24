extends PanelContainer
@export var file_picker: FileDialog
@export var button: Button
@export var sound_name_picker: LineEdit
@export var emoji_picker: LineEdit

signal new_sound(sound: SoundEffect)
var file: String = ""
func open_picker() -> void:
	file_picker.visible = true
	

func file_selected(f: String) -> void:
	file = f
	var filename: String = file.get_file().get_basename()
	if filename.length() > 36:
		filename = filename.substr(0, 33) + "..."
	button.text = filename


func _on_button_yes_pressed() -> void:
	if file != "":
		var sound: SoundEffect = SoundEffect.new()
		sound.path_to_sound = file
		sound.display_name = sound_name_picker.text
		sound.emoji = emoji_picker.text #hopefully this is an emoji, but it is max 1 char so doesn't necessarily matter
		new_sound.emit(sound)
		visible = false



func _on_button_no_pressed() -> void:
	visible = false
