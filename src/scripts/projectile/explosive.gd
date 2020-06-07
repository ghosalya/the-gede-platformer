extends KinematicBody2D

const speed = 500
var target_point = null
var direction = null
var PLAYER = null

var distance_travelled = 0
var max_distance = 200

const RADIUS = preload("res://scenes/projectile/explosive_rad.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	target_point = get_global_mouse_position()
	direction = (target_point - global_position).normalized()


func _physics_process(delta):
	var velocity = direction * speed *  delta
	var unit_hit = move_and_collide(velocity)
	if unit_hit:
		explode()
	
	distance_travelled += speed * delta
	if distance_travelled > max_distance:
		explode()
	
		
		
func explode():
	var exp_rad = RADIUS.instance()
	exp_rad.position = position
	get_parent().add_child(exp_rad)
	
	# can only attack after explosion
	PLAYER.can_attack = true
	get_parent().remove_child(self)
	
	
