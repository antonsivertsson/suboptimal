extends Area2D

func _on_Ladder_body_entered(body):
	if body.get_class() == "KinematicBody2D" && body.name != "Submarine":
		# TODO -> Check if type is player
		#if get_node(body.get_path()).isPlayer == true:
		get_node(body.get_path()).is_on_ladder = true


func _on_Ladder_body_exited(body):
	if body.get_class() == "KinematicBody2D" && body.name != "Submarine":
		#if get_node(body.get_path()).isPlayer == true:
		get_node(body.get_path()).is_on_ladder = false
