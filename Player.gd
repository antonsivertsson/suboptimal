extends KinematicBody2D
class_name Player

const UP = Vector2(0,-1)
const GRAVITY = 8
const WATER_GRAVITY = -2
const SPEED = 10
const MAX_SPEED = 150
const MAX_WATER_SPEED = 75
const JUMP_HEIGHT = -200

export(String) var UP_KEY# = "ui_up"
export(String) var DOWN_KEY# = "ui_down"
export(String) var RIGHT_KEY# = "ui_right"
export(String) var LEFT_KEY# = "ui_left"

var is_on_ladder = false;
var is_above_water = false;
var is_in_sub = true;
var is_at_console = false;

var motion = Vector2()

func is_on_ladder():
	return is_on_ladder;

func is_at_console():
	return is_at_console;

func is_in_water():
	return (!is_above_water && !is_in_sub);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# FIRST - Actions and vars that are always set
	var friction = false; # Use friction check to lerp where needed

	if Input.is_action_pressed(RIGHT_KEY):
		motion.x = min(motion.x + SPEED, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed(LEFT_KEY):
		$Sprite.flip_h = true
		$Sprite.play("Run")
		motion.x = max(motion.x - SPEED, -MAX_SPEED)
	else:
		friction = true;
		motion.x = lerp(motion.x, 0, 0.2);
		if !Input.is_action_pressed(DOWN_KEY) && !Input.is_action_pressed(UP_KEY): # If standing still while not pressing down
			$Sprite.play("Idle")


	# SECOND actions additional actions we need to check on_floor
	if is_on_ladder():
		if Input.is_action_pressed(UP_KEY):
			$Sprite.play("Run")
			motion.y = max(motion.y - SPEED, -MAX_SPEED)
		elif Input.is_action_pressed(DOWN_KEY):
			$Sprite.play("Run")
			motion.y = min(motion.y + SPEED, MAX_SPEED)
		else:
			motion.y = 0
	elif is_in_water():
		motion.y = min(motion.y + WATER_GRAVITY, MAX_WATER_SPEED)
		#motion.y = lerp(motion.y, WATER_GRAVITY, 0.02);
		if Input.is_action_just_pressed(UP_KEY):
			motion.y = max(motion.y - 60, -MAX_WATER_SPEED*2)
			#motion.y = -50
		elif Input.is_action_pressed(DOWN_KEY):
			motion.y = min(motion.y + 30, MAX_WATER_SPEED)
			#motion.y = 50

	else:
		motion.y += GRAVITY # GRAVITY enabled when not on ladders
		
		if is_at_console():
			if Input.is_action_pressed(UP_KEY):
				get_node("../../Submarine").rotate(rad2deg(-0.0001));
			elif Input.is_action_pressed(DOWN_KEY):
				get_node("../../Submarine").rotate(rad2deg(0.0001));
				
		elif is_on_floor():
			if Input.is_action_just_pressed(UP_KEY):
				motion.y = JUMP_HEIGHT
			elif Input.is_action_pressed(DOWN_KEY):
				$Sprite.play("Act")

			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2);
				
		else:
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05);
			if motion.y < 0:
				$Sprite.play("Jump")
			else:
				$Sprite.play("Fall")

	# FINAL - end process by commiting vector functions
	motion = move_and_slide(motion, UP)


