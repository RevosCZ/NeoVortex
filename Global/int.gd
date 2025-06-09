extends Node2D

@onready var unit = preload("res://Units/character.tscn")
var housePos = Vector2(200,0)

func _on_ok_pressed():
	Game.close_spawn_unit()
	queue_free()
