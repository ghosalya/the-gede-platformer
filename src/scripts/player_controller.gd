extends KinematicBody2D


# Declare member variables here.
const GRAVITY = 300.0
const WALK_SPEED = 150
const PROJECTILE = preload("res://scenes/projectile/throw_axe.tscn")
var facing = 1

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
	process_atk()
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
		if facing == 1:
			facing = -1
			scale.x = -1
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
		if facing == -1:
			facing = 1
			scale.x = -1
	else:
		velocity.x = 0

func process_jump():
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y += -300


func process_atk():
	if Input.is_action_just_pressed("player_atk"):
		var atk_proj = PROJECTILE.instance()
		print(atk_proj.get_child(0).facing)
		atk_proj.get_child(0).facing = facing
		atk_proj.position = position + Vector2(50 * facing, 0)
		get_parent().add_child(atk_proj)
