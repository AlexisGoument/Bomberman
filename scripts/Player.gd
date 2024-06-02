extends CharacterBody2D

const bomb_scene = preload("res://scenes/bomb.tscn")
const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_dropped_bomb = false
var dropped_bomb_coords

func _physics_process(delta):
	if has_dropped_bomb && player_is_on_bomb():
		has_dropped_bomb = false
	
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
	if !has_dropped_bomb:
		has_dropped_bomb = true
		dropped_bomb_coords = coords
		var bomb = bomb_scene.instantiate();
		bomb.position = coords
		bomb.get_node("CollisionShape2D").disabled = true
		get_parent().add_child(bomb)

func player_is_on_bomb():
	return (self.position.x >= dropped_bomb_coords.x 
	and self.position.x < dropped_bomb_coords.x + 16
	and self.position.y >= dropped_bomb_coords.y
	and self.position.y < dropped_bomb_coords.y + 16)
