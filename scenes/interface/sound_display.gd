extends VBoxContainer

var using_sound_file: bool
var sound_file: AudioStreamMP3
var sound_effect: SoundEffect

#function from AudioStreamMP3 page on godot docs
func load_mp3(path: String) -> AudioStreamMP3:
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound


func set_sound(sound: SoundEffect) -> void:
	if sound.is_sound_file():
		sound_file = load_mp3(sound.path_to_sound)
		using_sound_file = true
	else:
		push_warning("Wave sound playback not yet configured")
	$Button.text = sound.emoji
	$Label.text = sound.display_name

func play_sound() -> void:
	# doesn't matter if sound is already playing lol
	var sound_player: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(sound_player)
	sound_player.stream = sound_file
	sound_player.play()
	await sound_player.finished
	remove_child(sound_player) # very important for memory-efficiency
