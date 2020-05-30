extends KinematicBody2D


# Declare member variables here.
const GRAVITY = 300.0
const WALK_SPEED = 150
const EXPLOSIVE_PROJECTILE = preload("res://scenes/projectile/explosive_proj.tscn")
const BOOMERANG_PROJECTILE = preload("res://scenes/projectile/boomerang.tscn")

var PROJECTILE = null


var facing = 1
var can_attack = true
var axe_sprite = null
var atk_label = null

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("type", "player")
	axe_sprite = get_child(1)
	atk_label = get_child(3)
	PROJECTILE = EXPLOSIVE_PROJECTILE
	

func _physics_process(delta):
	
	process_gravity(delta)
	process_movement(delta)
	process_jump()
	process_attack_loadout()
	process_atk()
	axe_sprite.visible = can_attack
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
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y += -300


func process_atk():
	if Input.is_action_just_pressed("player_atk"):
		if can_attack:
			var atk_proj = PROJECTILE.instance()
			atk_proj.PLAYER = self
			atk_proj.position =  get_projectile_spawn_pos()
			get_parent().add_child(atk_proj)
			can_attack = false
		

func get_projectile_spawn_pos():
	return position + (get_global_mouse_position() - global_position).normalized() * 60
	

func process_attack_loadout():
	# Changing loadout is only for debugging. Actual gameplay won't let you do
	# this except in certain checkpoint.
	if Input.is_action_just_pressed("player_changeatk"):
		print("change_loadout")
		if PROJECTILE == EXPLOSIVE_PROJECTILE:
			PROJECTILE = BOOMERANG_PROJECTILE
			print("change to boomerang")
		elif PROJECTILE == BOOMERANG_PROJECTILE:
			PROJECTILE = EXPLOSIVE_PROJECTILE
			print("change to explosive")
			
	# change text
	if PROJECTILE == EXPLOSIVE_PROJECTILE:
		atk_label.text = "Explosive"
	if PROJECTILE == BOOMERANG_PROJECTILE:
		atk_label.text = "Boomerang"
