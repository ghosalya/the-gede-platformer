extends KinematicBody2D

const speed = 500
var target_point = null
var direction = null
var PLAYER = null

var distance_travelled = 0
var max_distance = 500
var returning = false

# Called when the node enters the scene tree for the first time.
func _ready():
	target_point = get_global_mouse_position()
	direction = (target_point - global_position).normalized()


func _physics_process(delta):
	if returning:
		direction = (PLAYER.global_position - global_position).normalized()
		
	var velocity = direction * speed *  delta
	var unit_hit = move_and_collide(velocity)
	
	distance_travelled += speed * delta
	
	if distance_travelled > max_distance:
		returning = true
	
	if unit_hit:
		if "type" in unit_hit.collider.get_meta_list():
			if unit_hit.collider.get_meta("type") == "enemy":
				unit_hit.collider.damage(1)
				
				# TODO: implement going through enemies and remove the
				#		"return on hit" implementation
				returning = true
				
			if unit_hit.collider.get_meta("type") == "player":
				# can only attack once boomerang is back
				PLAYER.can_attack = true
				get_parent().remove_child((self))
				
		else:
			# if it hits any other object, return
			returning = true
	
