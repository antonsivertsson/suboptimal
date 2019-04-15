extends Area2D

onready var submarine = get_node("/root/Node2D/Submarine")
onready var sceneRoot = get_node("/root/Node2D")

func _on_sky_body_entered(body):
	if body.get_class() == "KinematicBody2D" && body.name != "Submarine":
		get_node(body.get_path()).is_above_water = true

func _on_sky_body_exited(body):
	if body.get_class() == "KinematicBody2D" && body.name != "Submarine":
		get_node(body.get_path()).is_above_water = false

func _on_SubArea_body_entered(body):
	if body.get_class() == "KinematicBody2D" && body.name != "Submarine":
		print("ENTERING SUB")
		var player = get_node(body.get_path())
		var old_position = player.global_position
		player.is_in_sub = true
		sceneRoot.remove_child(player);
		submarine.add_child(player)
		player.global_position = old_position

func _on_SubArea_body_exited(body):
	if body.get_class() == "KinematicBody2D" && body.name != "Submarine":
		print("EXITING SUB")
		var player = get_node(body.get_path())
		var old_position = player.global_position
		player.is_in_sub = false
		submarine.remove_child(player)
		sceneRoot.add_child(player);
		player.global_position = old_position

func _on_Console_body_entered(body):
	if body.get_class() == "KinematicBody2D" && body.name != "Submarine":
		get_node(body.get_path()).is_at_console = true

func _on_Console_body_exited(body):
	if body.get_class() == "KinematicBody2D" && body.name != "Submarine":
		get_node(body.get_path()).is_at_console = false
