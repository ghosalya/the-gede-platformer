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
	# set_rotation_degrees((get_rotation_degrees() + 540 * delta) * facing)
	
	var velocity = Vector2(1, 0) * speed * facing * delta
	var unit_hit = move_and_collide(velocity)
	
	if unit_hit:
		if "type" in unit_hit.collider.get_meta_list():
			if unit_hit.collider.get_meta("type") == "enemy":
				unit_hit.collider.take_damage(1)
			
		get_parent().remove_child(self)
	
	
