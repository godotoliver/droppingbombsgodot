extends Node3D

@export var rocket: PackedScene
@onready var game_start = get_node("UserInterface/GameStart")
@onready var game_end = get_node("UserInterface/GameEnd")
var player: Node
@onready var score_label = get_node("UserInterface/ScoreCanvas/Score")
@onready var best_score = get_node("UserInterface/ScoreCanvas/HighScore")
var high_score: int


func _ready() -> void:
	Globals.hit.connect(game_over)
	game_start.visible = true
	Globals.spawning = false
	game_end.visible = false
	Globals.score = 0
	Globals.score_changed.connect(update_score)
	high_score = 0


func _process(_delta: float) -> void:
	if (Input.is_anything_pressed() && Globals.spawning == false):
		if Globals.started: 
			await get_tree().create_timer(1).timeout 
			restart()
		else: 
			game_start.visible = false
			Globals.spawning = true
			spawn_player()


func game_over():
	# TODO #4: destroy the player before timer so the game can't continue
	player.queue_free()
	# TODO #3: create timer so you can see the explosion
	await get_tree().create_timer(1).timeout
	game_end.visible = true
	Globals.started = true
	Globals.spawning = false
	if Globals.score > high_score:
		high_score = Globals.score
		update_high_score(Globals.score)
	Globals.score = 0
	update_score(Globals.score)


func restart():
	game_end.visible = false
	Globals.started = false
	Globals.spawning = true
	spawn_player()


func spawn_player():
	var rockets = get_tree().get_nodes_in_group("Rocket")
	if rockets.is_empty(): #to prevent spawning mutliple rockets
		player = rocket.instantiate()
		player.position = Vector3(0,-4.3,0)
		add_child(player)


func update_score(score: int) -> void: 
	score_label.text = "Score: " + str(score) 


func update_high_score(score: int) -> void:
	best_score.text = "High Score: " + str(score) 
