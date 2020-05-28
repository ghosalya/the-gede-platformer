extends Control

const scene = preload("res://scenes/levels/tryscene.tscn")


func _ready():
	pass


func _on_StartButton_pressed():
	var level = scene.instance()
	get_node("/root").add_child(level)
	self.visible = false


func _on_ContinueButton_pressed():
	print("Continue not implemented")


func _on_ExitButton_pressed():
	get_tree().quit()

