extends Control


var noise_maker: NoiseMaker


func _ready() -> void:
	#noise_maker = NoiseMaker.new()
	#$Audio.play()
	#noise_maker.start(1000, $Audio.stream, $Audio.get_stream_playback(), 300, 0.1, true)
	$Panel/Container/VBoxContainer/PanelContainer/MarginContainer/VScrollBar/VBoxContainer/HBoxContainer/VBoxContainer.set_sound(load("res://example_sound_effect.tres"))



func _process(_delta: float) -> void:
	pass#noise_maker.every_frame()
