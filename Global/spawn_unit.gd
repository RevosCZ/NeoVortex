extends Node2D

@onready var unit = preload("res://Units/character.tscn")
var housePos = Vector2(200,0)

func _on_yes_pressed() -> void:
	if Game.Treats < 10:
		return
	Game.Treats -= 10
	var unitPath = get_tree().get_root().get_node("World/Units")
	var worldPath = get_tree().get_root().get_node("World")
	var unit1 = unit.instantiate()
	
	var randomPosX = randi_range(-50, 50)
	var randomPosY = randi_range(-50, 50)
	
	unit1.position = housePos + Vector2(randomPosX, randomPosY)
	unitPath.add_child(unit1)
	worldPath.get_units()

func _on_no_pressed():
	var houses_node: Node2D = get_tree().get_root().get_node("World/Buildings")
	for i: int in houses_node.get_child_count():
		if houses_node.get_child(i).Selected == true:
			houses_node.get_child(i).Selected = false
	Game.close_spawn_unit()
	queue_free()
