extends Node2D

enum { OBSTACLE, COLLECTABLE, RESOURCE }

var tile_size: int = 16
var house_size:int = 5
var grid_size: Vector2i = Vector2i(200, 200)
var grid: Array = []

var boss: PackedScene = preload("res://Objects/boss.tscn")
var treehouse: PackedScene = preload("res://Buildings/TreeHouse.tscn")
var speedhouse: PackedScene = preload("res://Buildings/SpeedHouse.tscn")
var altar: PackedScene = preload("res://Buildings/Altar.tscn")


func _ready():
	init_empty_grid()
	init_trees()
	


func init_empty_grid() -> void:
	for x: int in range(grid_size.x):
		grid.append([])
		for y: int in range(grid_size.y):
			grid[x].append(null)


func init_trees() -> void:
	var positions: Array = []
	for i: int in range(150):
		var x_coor: int = randi() % int(grid_size.x) - 100
		var y_coor: int = randi() % int(grid_size.y) - 100
		var grid_position: Vector2i = Vector2i(x_coor, y_coor)
		if not grid_position in positions:
			positions.append(grid_position)
	
	for pos: Vector2i in positions:
		var boss_instance: StaticBody2D = boss.instantiate()
		boss_instance.set_position(tile_size * pos)
		grid[pos.x][pos.y] = OBSTACLE
		add_child(boss_instance)


func try_place_building(costs: Dictionary, scene: PackedScene, parent_node_path: NodePath):
	# Check if player has enough of each resource
	for resource_name in costs.keys():
		if not resource_name in ["Honor", "Treats", "Zoomies"]:
			return
		if Game.get(resource_name) < costs[resource_name]:
			return

	var mouse_position: Vector2 = get_global_mouse_position()
	var multi_x: int = int(round(mouse_position.x) / house_size)
	var multi_y: int = int(round(mouse_position.y) / house_size)
	var new_pos: Vector2i = Vector2i(multi_x, multi_y)

	# Check surroundings
	for i: int in range(house_size):
		if grid[multi_x + i][multi_y] != null \
		or grid[multi_x - i][multi_y] != null \
		or grid[multi_x][multi_y + i] != null \
		or grid[multi_x][multi_y - i] != null:
			return  # Don't place, no refund

	if grid[multi_x][multi_y] == null:
		# Deduct all costs
		for resource_name in costs.keys():
			Game.set(resource_name, Game.get(resource_name) - costs[resource_name])

		var instance: StaticBody2D = scene.instantiate()
		instance.position = house_size * new_pos
		grid[multi_x][multi_y] = OBSTACLE
		get_node(parent_node_path).add_child(instance)


func _unhandled_input(event):
	if event.is_action_pressed("Building"):
		try_place_building({"Honor": 5}, treehouse, "../Resources")
	elif event.is_action_pressed("Speed"):
		try_place_building({"Treats": 200}, speedhouse, "../Speed")
	elif event.is_action_pressed("Altar"):
		try_place_building({"Zoomies": 100, "Treats": 1000}, altar, "../Altar")
