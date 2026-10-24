extends Object

class_name NoiseMaker
var frequency: float = 440 #hz of sine wave to generate
var audio_stream_generator: AudioStreamGenerator
var playback: AudioStreamGeneratorPlayback
var phase: float = 0
var secondary_phase: float = 0
var sfi: float
var sfcr: float
@export var snapped_sound: bool #named to differentiate variable from built-in func

func start(fr: float, generator: AudioStreamGenerator, pb: AudioStreamGeneratorPlayback, second_freq_influence: float, second_freq_change_rate: float, s:bool) -> void: 
	frequency = fr
	audio_stream_generator = generator
	playback = pb
	sfcr = second_freq_change_rate
	sfi = second_freq_influence
	snapped_sound = s


func every_frame():
	secondary_phase += sfcr
	frequency = 200 + sfi*sin(secondary_phase/2* PI)
	if playback != null:
		fill_buffer()

func fill_buffer() -> void:
	var increment: float = frequency / audio_stream_generator.mix_rate
	var frames_available: int = playback.get_frames_available()
	
	for i in range(frames_available):
		# Generate a sine wave sample (Left and Right channel)
		var sample: float
		if snapped_sound:
			sample = snapped(sin(phase * TAU), 1)
		else:
			sample = sin(phase * TAU)
		playback.push_frame(Vector2(0,1) * sample)
		phase = fmod(phase + increment, 1.0)
