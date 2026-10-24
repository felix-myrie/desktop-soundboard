extends VBoxContainer

const CONFIG_SAVE_PATH = "user://config.tres"
signal state_updated(new_state: AppState)

func _ready() -> void:
	var state: AppState
	if can_load_state_file():
		state = load_state_file()
		visible = false
		state_updated.emit(state)
	else:
		state = AppState.new()
	

func can_load_state_file() -> bool:
	if ResourceLoader.exists(CONFIG_SAVE_PATH):
		return (load(CONFIG_SAVE_PATH) is AppState)
	else:
		return false

func load_state_file() -> AppState:
	if can_load_state_file():
		return load(CONFIG_SAVE_PATH)
	else:
		push_error("attempted to load state file but none was found. check can_load_state_file before loading")
		return AppState.new()

func _on_check_button_toggled(toggled_on: bool) -> void:
	$HBoxContainer.visible = toggled_on

func _submit() -> void:
	var state: AppState = AppState.new()
	state.opaque_background = $OpaqueBackgroundToggle.button_pressed
	if $OpaqueBackgroundToggle.button_pressed:
		state.background_colour = $HBoxContainer/ColorPicker.color
	else:
		state.background_colour = Color.RED #doesn't matter, just stopping null reference
	state.user_name = $NameEdit.text
	state.use_built_in_sounds = ! $BuiltInSoundToggle.button_pressed # button represents opposite


func apply_new_state(state: AppState):
	state_updated.emit(state)
	ResourceSaver.save(state, CONFIG_SAVE_PATH)
