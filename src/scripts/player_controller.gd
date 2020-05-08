extends KinematicBody2D


# Declare member variables here.
const GRAVITY = 300.0
const WALK_SPEED = 150

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	
	process_gravity(delta)
	process_movement(delta)
	process_jump()
	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	move_and_slide(velocity, Vector2(0, -1))


func process_gravity(delta):
	if not is_on_floor():
		velocity.y += delta * GRAVITY
	else:
		velocity.y = 0
		

func process_movement(delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
	else:
		velocity.x = 0

func process_jump():
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y += -300
