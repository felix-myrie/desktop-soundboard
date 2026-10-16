extends HBoxContainer

var dragging: bool = false
var drag_offset: Vector2

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			drag_offset = get_global_mouse_position()

func _process(_delta: float) -> void:
	if dragging:
		get_window().position = get_global_mouse_position() + Vector2(get_window().position) - Vector2(drag_offset) # do vector calculation for half of the width

# Connect your buttons to these functions:
func _on_close_pressed() -> void:
	get_tree().quit()

func _on_minimize_pressed() -> void:
	get_window().mode = Window.MODE_MINIMIZED

func _on_maximize_pressed() -> void:
	var win = get_window()
	if win.mode == Window.MODE_MAXIMIZED:
		win.mode = Window.MODE_WINDOWED
	else:
		win.mode = Window.MODE_MAXIMIZED
