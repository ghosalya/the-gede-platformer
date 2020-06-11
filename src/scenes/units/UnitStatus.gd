extends Control


func on_health_change(health, maxHealth):
	$HealthBar.value = health;
	$HealthBar.max_value = maxHealth;
