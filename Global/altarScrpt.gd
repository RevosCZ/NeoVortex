extends Node2D

@onready var unit: PackedScene = preload("res://Units/character.tscn")
var housePos: Vector2 = Vector2(200,0)

func _on_yes_pressed() -> void:
	var unitPath = get_tree().get_root().get_node("World/Units")
	for child in unitPath.get_children():
		child.queue_free()
		
	Game.shield = false

func _on_no_pressed():
	var houses_node: Node2D = get_tree().get_root().get_node("World/Altar")
	for i: int in houses_node.get_child_count():
		if houses_node.get_child(i).Selected == true:
			houses_node.get_child(i).Selected = false
	Game.close_altar()
	queue_free()
