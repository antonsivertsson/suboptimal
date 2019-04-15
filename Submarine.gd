extends RigidBody2D

class_name Submarine

var depth
var current_pressure
var battery_level
var oxygen_level # Given that this is global for entire sub
var rot = 0.0

const UP = Vector2(0,-1)

func _integrate_forces(state):
	set_applied_force(transform.x * 15)
	#move_and_slide(transform.x * 15)

#	var rot_speed = rad2deg(-0.0001)  # 30 deg/sec
#	rotate(rot_speed)