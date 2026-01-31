extends Node

@export var music_player: AudioStreamPlayer

@export var game: AudioStreamMP3
@export var samba: AudioStreamMP3

func _ready():
	music_player.stream = samba
	music_player.play()

func play_music():
	if not music_player.playing:
		music_player.play()

func stop_music():
	music_player.stop()

func switch_song():
	if music_player.stream == samba:
		music_player.stream = game
		music_player.play()
	else:
		music_player.stream = samba
		music_player.play()
