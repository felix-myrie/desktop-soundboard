extends SoundEffect
class_name WaveSoundEffect

var frequency: int

var second_freq_change_rate: int
var second_freq_influence: int
var snapped: bool

func is_sound_effect() -> bool:
	return false
