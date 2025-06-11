extends Node2D

enum { OBSTACLE, COLLECTABLE, RESOURCE }

var tile_size: int = 16
var house_size: int = 5
var grid_size: Vector2i = Vector2i(1500, 1500)
var grid: Dictionary = {}

var boss: PackedScene = preload("res://Objects/boss.tscn")
var treehouse: PackedScene = preload("res://Buildings/TreeHouse.tscn")
var speedhouse: PackedScene = preload("res://Buildings/SpeedHouse.tscn")
var altar: PackedScene = preload("res://Buildings/Altar.tscn")

func _ready():
	init_empty_grid()
	init_boss()

func init_empty_grid() -> void:
	for x in range(-grid_size.x / 2, grid_size.x / 2):
		grid[x] = {}
		for y in range(-grid_size.y / 2, grid_size.y / 2):
			grid[x][y] = null

func init_boss() -> void:
	var half_width: int = 120  # Total area
	var boss_count: int = 250
	var placed := 0

	while placed < boss_count:
		var x := randi_range(-half_width, half_width)
		var y := randi_range(-half_width, half_width)

		# Avoid placing on exact center
		if x == 0 and y == 0:
			continue

		# Ensure valid position and not already used
		if grid.has(x) and grid[x].has(y) and grid[x][y] == null:
			var boss_instance: StaticBody2D = boss.instantiate()
			boss_instance.position = tile_size * Vector2(x, y)
			grid[x][y] = OBSTACLE
			add_child(boss_instance)
			placed += 1


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
