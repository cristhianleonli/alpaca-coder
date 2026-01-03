extends Node

const POOL_SIZE: int = 5

@onready var music_player: AudioStreamPlayer2D = $MusicStreamPlayer
@onready var effects_pool: Node2D = $EffectsPool

@export var game_audio: GameAudio
var sfx_players: Array[AudioStreamPlayer] = []

func _ready() -> void:
	for i in range(0, POOL_SIZE):
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		effects_pool.add_child(player)
		sfx_players.append(player)
	
func play_sound(setting: AudioSetting) -> void:
	var player: AudioStreamPlayer = get_next_sfx_player()
	player.stream = setting.source
	player.volume_db = setting.volume_db
	player.pitch_scale = get_random_pitch(setting.pitch_randomness)
	player.bus = "SFX"
	player.play()
	
func get_next_sfx_player() -> AudioStreamPlayer:
	for player: AudioStreamPlayer in sfx_players:
		if not player.playing:
			return player
	
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	player.set_meta("temp", true)
	player.finished.connect(on_player_finished.bind(player))
	
	effects_pool.add_child(player)
	return player
	
func on_player_finished(player: AudioStreamPlayer) -> void:
	if player.has_meta("temp"):
		player.queue_free()
	
func get_random_pitch(randomness: float) -> float:
	if randomness == 0:
		return 1.0
	
	return randf_range(1.0 - randomness, 1.0 + randomness)

func play_music() -> void:
	music_player.stream = game_audio.main_music.source
	music_player.volume_db = game_audio.main_music.volume_db
	music_player.play()
