extends Node

@export var mob_scene: PackedScene
var score

#var background_music = preload("res://music/410574__yummie__game-background-music-loop-short.mp3")

# Dictionary to store audio files
#var audio_files = {}
# Variable to keep track of the currently playing AudioStreamPlayer
var current_audio_player: AudioStreamPlayer2D
var explode_audio_player: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass #new_game()
	
	
	# Load music files from the directory
	#var dir = DirAccess.open("res://music")
	#if dir != null:
	#	var file_name = dir.get_next()
	#	while file_name != "":
	#		if !dir.current_is_dir() and file_name.ends_with(".mp3"):
	#			var file_path = "res://music/" + file_name
	#			audio_files[file_name] = load(file_path)
	#		file_name = dir.get_next()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop() 
	$HUD.show_game_over()
	explode_audio_player.play()
	#Stop the audio when the game is over
	stop_audio()
	
	
	
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	
	#start the audio when the game starts
	#play_audio(background_music)
	#play_audio("410574__yummie__game-background-music-loop-short.mp3")
	
	explode_audio_player = $ExplodeSound
	current_audio_player  = $GameAudioPlayer	
	current_audio_player.play()

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	
#func play_audio(file_name) -> void:
	# Check if the audio file exists in the dictionary
	#if file_name in audio_files:
		# Stop any currently playing audio
		#stop_audio()

		# Create a new AudioStreamPlayer and set the stream
		#current_audio_player = AudioStreamPlayer.new()
		#current_audio_player.volume_db = 0.0 
		#current_audio_player.stream = load(file_path)
		#add_child(current_audio_player)
		
		# Start playing the audio
		


func stop_audio():
	# Stop and remove the current audio player if it exists
	if current_audio_player:
		current_audio_player.stop()
		#remove_child(current_audio_player)
		#current_audio_player.queue_free()
		#current_audio_player = null	
