extends Node3D

@export var bomb_object : PackedScene
var main_camera : Camera3D
var spawn_x: float
var spawn_y: float

func _ready() -> void:
	main_camera = get_viewport().get_camera_3d()
	spawn_x = main_camera.get_viewport().size.x/100
	spawn_y = main_camera.get_viewport().size.y/100
	

func _on_timer_timeout() -> void:
	if (Globals.spawning == true ): 
		var bomb = bomb_object.instantiate()
		bomb.position = Vector3(randf_range(spawn_x, -spawn_x),spawn_y + 5, 0)
		add_child(bomb)


func _process(_delta: float) -> void:
	var all_bombs = get_tree().get_nodes_in_group("Bomb")
	for bombs in all_bombs:
		if (bombs.position.y < -60) or (Globals.spawning == false): # new 
			bombs.queue_free()
			if Globals.spawning == true:
				Globals.change_score(1)
