extends CharacterBody2D

const bomb_scene = preload("res://scenes/bomb.tscn")
const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("direction_left", "direction_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	direction = Input.get_axis("direction_up", "direction_down")
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("drop_bomb"):
		drop_bomb(self.position)

func drop_bomb(coords: Vector2i):
	var dropped_bomb = bomb_scene.instantiate();
	dropped_bomb.position = coords
	get_parent().add_child(dropped_bomb)
