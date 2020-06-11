extends KinematicBody2D


class_name Unit


signal on_health_change(health, maxHealth);


var maxHealth = 10;
var health = 10;


func _ready():
	health = maxHealth;

	emit_signal("on_health_change", health, maxHealth);


func damage(amount: float):
	health -= amount;
	emit_signal("on_health_change", health, maxHealth);

	if health <= 0:
		die();


func die():
	queue_free();
