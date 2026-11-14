extends Node3D

@export var speed: float = 10.0

@onready var screenSize = get_viewport().get_camera_3d()
@onready var AnimTree = get_node("AnimationTree")

# A function that happens at the end of the frame when all of the physics are processed
func _physics_process(delta):
	# Sets left and right and up and down based on preset controls being up, down, left, and right buttons
	var horizontal: float = Input.get_axis("ui_left", "ui_right")
	if Input.is_key_pressed(KEY_A):
		horizontal = -1
	if Input.is_key_pressed(KEY_D):
		horizontal = 1
	var vertical: float = Input.get_axis("ui_down","ui_up")
	if Input.is_key_pressed(KEY_S):
		vertical = -1
	if Input.is_key_pressed(KEY_W):
		vertical = 1
	
	# Creates the final movement variable based on the final variables
	var movement = Vector3(horizontal,vertical, position.z)
	#	vvvvvvADDED IN PART 2vvvvvvv
	# Sets the direction the rocket will tilt in.
	AnimTree["parameters/Blend3/blend_amount"] = horizontal;
	#	^^^^^^ADDED IN PART 2^^^^^^^
	# Sets the position based on that movement variable times the time passed times the set speed
	position += movement * delta * speed
	
# Needed to allow the player to select the camera theyre using.
# Called every physics frame. 'delta' is the elapsed time since the previous frame.
	# Makes a variable for each side of the viewport, then reduces it by the size of the parent object to make it. more accurate
	var leftSide = (-screenSize.get_viewport().size.x/100) + (scale.x * 10)
	var rightSide = (screenSize.get_viewport().size.x/100) - (scale.x * 10)
	var upSide = (screenSize.get_viewport().size.y/100) - (scale.y * 5)
	var downSide = (-screenSize.get_viewport().size.y/100) + (scale.y * 5)
	
	# If the parent is on the right or left side of the screen.
	if position.x > rightSide || position.x < leftSide:
		# Clamp it's position to be back inside the screen.
		position.x = clamp(position.x, leftSide, rightSide)
	# If the parent is on the top or bottom side of the screen.
	if position.y > upSide || position.y < downSide:
		# Clamp it's position to be back inside the screen.
		position.y = clamp(position.y, downSide, upSide)
