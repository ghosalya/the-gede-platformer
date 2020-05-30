extends Area2D


# Declare member variables here. Examples:
const FADE_SPEED = 3
const DAMAGE = 3

var PLAYER = null
var visible_factor = 1.0

var sprite = null
var collider = null


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_child(0)
	collider = get_child(1)
	
	
func damage_units_in_radius():
	# damage enemies in range
	var units_in_range = get_overlapping_bodies()
	
	for i in range(0, units_in_range.size()):
		var unit_hit = units_in_range[i]
		if "type" in unit_hit.get_meta_list():
			if unit_hit.get_meta("type") == "enemy":
				unit_hit.take_damage(DAMAGE)
			if unit_hit.get_meta("type") == "player":
				unit_hit.get_parent().remove_child(unit_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	damage_units_in_radius()
	
	visible_factor -= FADE_SPEED * delta
	sprite.modulate = Color(1, 1, 1, visible_factor)
	
	if visible_factor <= 0:
		get_parent().remove_child(self)
