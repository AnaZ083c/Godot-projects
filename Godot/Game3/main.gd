extends Node2D

export var enemy_num : int = 4
export (PackedScene) var enemy

export var speed_change = 1
export var stage_change_time = 10000  # msec

onready var stage = 1

onready var beg_ticks = OS.get_ticks_msec()

var high_score_path = "res://high_score.score"
var savegame = File.new()
var save = {"highscore": 0}
var highscore

var settings_path = "res://settings.set"
var settings = File.new()
var settings_save = {"enemy_num": 4, "start_stage": 1}

var paused : bool = false

func reset_game():
	$player.game_over = false
	$game_over.hide()
	highscore = read_high_score()
	if stage >= highscore:
		save_high_score(stage)
	highscore = stage
	stage = 1
	
	for i in range(2, enemy_num+2):
		var enemy = $enemy_spawn.get_child(i)
		enemy.init()
	
	beg_ticks = OS.get_ticks_msec()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	pause_mode = Node.PAUSE_MODE_PROCESS
	$game_over.hide()
	
	if not savegame.file_exists(high_score_path):
		create_save()
	
	var settings_read = read_settings()
	enemy_num = settings_read[0]
	stage = settings_read[1]
	change_wall_speed_by_n(stage-1)
	change_player_speed_by_n(stage-1)
	
	highscore = read_high_score()
	$GUI/HBoxContainer/VBoxContainer/stage_counter/high_score_label/high_score/count.text = str(highscore)
	
	for i in range(enemy_num):
		$enemy_spawn.add_child(enemy.instance())
		
	change_enemy_speed_by_n(stage-1)
	stage = 1

func _input(event):
	if event.is_action_pressed("reset") and paused:
		paused = false
		get_tree().paused = false
		reset_game()
		get_tree().reload_current_scene()
		
	if event.is_action_pressed("ui_cancel"):
		if paused:
			paused = false
			get_tree().paused = false
			reset_game()
		get_tree().change_scene("res://Scenes/menu.tscn")

func _process(delta):
	if $player.game_over:
		$game_over.show()
		get_tree().paused = true
		paused = true
	
	else:
		var current_ticks = OS.get_ticks_msec()
		if current_ticks - beg_ticks >= stage_change_time:
			stage += 1
			$GUI/HBoxContainer/VBoxContainer/stage_counter/stage_label/stage/count.text = str(stage)
			change_enemy_speed()
			change_wall_speed()
			change_player_speed()
			beg_ticks = current_ticks
		

######### MY FUNCTIONS #######################

func change_enemy_speed_by_n(n):
	for i in range(2, enemy_num+2):
		var _enemy = $enemy_spawn.get_child(i)
		_enemy.speed += (speed_change * n)
		
func change_wall_speed_by_n(n):
	for i in range($walls.get_child_count()):
		var wall = $walls.get_child(i)
		wall.speed += (speed_change * n)

func change_player_speed_by_n(n):
	$player.speed += (speed_change * n)

func change_enemy_speed():
	for i in range(2, enemy_num+2):
		var _enemy = $enemy_spawn.get_child(i)
		_enemy.speed += speed_change

func change_wall_speed():
	for i in range($walls.get_child_count()):
		var wall = $walls.get_child(i)
		wall.speed += speed_change

func change_player_speed():
	$player.speed += speed_change
	
func read_high_score():
	savegame.open(high_score_path, File.READ)
	save = savegame.get_var()
	savegame.close()
	return save["highscore"]
	
func read_settings():
	settings.open(settings_path, File.READ)
	settings_save = settings.get_var()
	settings.close()
	return [settings_save["enemy_num"], settings_save["start_stage"]]
	
func save_high_score(high_score):
	save["highscore"] = high_score
	savegame.open(high_score_path, File.WRITE)
	savegame.store_var(save)
	savegame.close()
	
func create_save():
	savegame.open(high_score_path, File.WRITE)
	savegame.store_var(save)
	savegame.close()

func explode_player():
	$player/car.hide()
	$player/car_explosion.show()
	$player/car_explosion.play("explode")

################ SIGNALS ###################

func _on_game_over_visibility_changed():
	if $game_over.visible:
		$game_over_sfx.play()
		$car_exploded.play()
		explode_player()
