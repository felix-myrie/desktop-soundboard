extends Control

const AUDIO_DISPLAY_PATH : String = "res://scenes/interface/sound_display.tscn"
#scene tree links 
@export var main_scene: MarginContainer
@export var settings_scene: VBoxContainer
@export var opaque_background: ColorRect
@export var scroller: GridContainer
@export var sound_deleter: PanelContainer
@export var sound_adder: VBoxContainer
@export var reset_box: VBoxContainer
@export var sound_adder_popup: PanelContainer
#key exports used in app
@export var built_in_sounds: Array[SoundEffect] = []

#variables used in code
var noise_maker: NoiseMaker
var sounds: Array[SoundEffect] = []

func _ready() -> void:
	
	#noise_maker = NoiseMaker.new()
	#$Audio.play()
	#noise_maker.start(1000, $Audio.stream, $Audio.get_stream_playback(), 300, 0.1, true)
	pass#$Panel/Container/VBoxContainer/PanelContainer/MarginContainer/VScrollBar/VBoxContainer/HBoxContainer/VBoxContainer.set_sound(load("res://example_sound_effect.tres"))

func _apply_state(state: AppState) -> void:
	print('done')
	for c in scroller.get_children():
		scroller.remove_child(c)
	
	opaque_background.visible = state.opaque_background
	opaque_background.color = state.background_colour
	settings_scene.get_parent().visible = false
	main_scene.visible = true
	sounds  = []
	for s in state.sound_effects:
		sounds.append(s)
	if state.use_built_in_sounds:
		for s in built_in_sounds:
			sounds.append(s)

	var audio_display: PackedScene = load(AUDIO_DISPLAY_PATH)
	
	for sound in sounds:
		if audio_display.can_instantiate():
			var displayer = audio_display.instantiate()
			displayer.connect('remove_sound_request', request_sound_deletion)
			displayer.set_sound(sound)
			scroller.add_child(displayer)
		else:
			push_warning('cannot instantiate audio display')
	scroller.add_child(sound_adder)
	scroller.add_child(reset_box)
	#sound_adder.connect('add_new_sound', request_add_sound)
	

func request_sound_deletion(sound: SoundEffect) -> void:
	if !(sound in built_in_sounds): #we don't delete built-in sounds
		sound_deleter.request_sound_deletion(sound)

func delete_sound(sound: SoundEffect) -> void:
	var state: AppState = settings_scene.load_state_file()

	var to_be_removed: Array[int] = []

	for n in range(state.sound_effects.size()):
		if state.sound_effects[n] == sound:
			to_be_removed.append(n)

	for n in range(to_be_removed.size() - 1, -1, -1):
		state.sound_effects.remove_at(to_be_removed[n])

	settings_scene.apply_new_state(state)

func request_add_sound() -> void:
	print('add sound')
	sound_adder_popup.visible = true
	
func add_sound(sound: SoundEffect) -> void:
	var state: AppState = settings_scene.load_state_file()
	state.sound_effects.append(sound)
	settings_scene.apply_new_state(state)

func settings() -> void:
	print('heloo')
	main_scene.visible = false
	settings_scene.get_parent().visible = true
	await settings_scene.update()
	main_scene.visible = true
	settings_scene.get_parent().visible = false
