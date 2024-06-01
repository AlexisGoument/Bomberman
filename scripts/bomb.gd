extends StaticBody2D
@onready var ray_cast_up = $Bomb/RayCastUp
@onready var ray_cast_down = $Bomb/RayCastDown
@onready var ray_cast_left = $Bomb/RayCastLeft
@onready var ray_cast_right = $Bomb/RayCastRight
@onready var tilemap = $"../TileMap"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func explode():
	explode_direction(ray_cast_left)
	explode_direction(ray_cast_right)
	explode_direction(ray_cast_up)
	explode_direction(ray_cast_down)
	
func explode_direction(raycast):
	if ray_cast_left.is_colliding():
		var rid = ray_cast_left.get_collider_rid()
		tilemap.get_coords_for_body_rid(rid)
		tilemap.erase_cell(0, tilemap.get_coords_for_body_rid(rid))
