extends Node2D


export(float) var SPEED = 0.0;


func _physics_process(delta):
	var p: PathFollow2D = get_parent();
	p.set_offset(p.get_offset() + delta * SPEED);
