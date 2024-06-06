extends StaticBody2D

const explosion_scene = preload("res://scenes/explosion.tscn")

@onready var collision_shape_2d = $CollisionShape2D

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		collision_shape_2d.set_deferred("disabled", false)

func explode():
	var explosion = explosion_scene.instantiate()
	print("explosion position: ", self.position)
	explosion.position = self.position
	add_child(explosion)
