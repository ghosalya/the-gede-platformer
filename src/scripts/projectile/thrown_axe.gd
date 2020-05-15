extends KinematicBody2D

const speed = 500
var init_rotation = 0
var facing = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	init_rotation = rotation
	scale.x = facing


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var velocity = Vector2(1, 0) * speed * facing
	move_and_slide(velocity)
	
	set_rotation_degrees((get_rotation_degrees() + 540 * delta) * facing)
