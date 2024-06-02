extends Node2D

const powerup_scene = preload("res://scenes/strength_powerup.tscn")
const TILESIZE = 16

func create_powerup(coords: Vector2i):
	var powerup = powerup_scene.instantiate();
	var coords_px = coords * 16
	powerup.position = coords_px
	add_child(powerup)
