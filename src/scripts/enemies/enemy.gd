extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxHealth = 2
var health = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("type", "enemy")
	health = maxHealth
	

func take_damage(dmg_amount):
	health -= dmg_amount
	
	if health <= 0:
		get_parent().remove_child(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
