extends StaticBody2D
@onready var ray_cast_up = $Bomb/RayCastUp
@onready var ray_cast_down = $Bomb/RayCastDown
@onready var ray_cast_left = $Bomb/RayCastLeft
@onready var ray_cast_right = $Bomb/RayCastRight
@onready var tilemap: TileMap = $"../TileMap"

const TILESIZE = 16
const WALL_ATLAS_COORDS = Vector2i(2, 6)
const WALL_BONUS_ATLAS_COORDS = Vector2i(2, 5)
var bombLength = 1

func explode():
	ray_cast_left.target_position.x = bombLength * TILESIZE * -1
	ray_cast_right.target_position.x = bombLength * TILESIZE
	ray_cast_up.target_position.y = bombLength * TILESIZE * -1
	ray_cast_down.target_position.y = bombLength * TILESIZE
	explode_direction(ray_cast_left)
	explode_direction(ray_cast_right)
	explode_direction(ray_cast_up)
	explode_direction(ray_cast_down)
	
func explode_direction(raycast: RayCast2D):
	if raycast.is_colliding():
		var rid = raycast.get_collider_rid()
		explode_body(rid)
		
func explode_body(rid: RID):
	var coords = tilemap.get_coords_for_body_rid(rid)
	var atlas_coords = tilemap.get_cell_atlas_coords(0, coords);
	if atlas_coords == WALL_ATLAS_COORDS:
		tilemap.erase_cell(0, coords)
	elif atlas_coords == WALL_BONUS_ATLAS_COORDS:
		tilemap.erase_cell(0, coords)
		print(get_parent().create_powerup(coords))
