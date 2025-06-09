
extends CharacterBody2D

@export var selected: bool = false
@onready var box: Panel = $Box
@onready var animation: AnimationPlayer = $AnimationPlayer

@onready var target = position
var folow_cursor: bool = false


func _ready():
	set_selected(selected)
	add_to_group("units", true)


func set_selected(_selected: bool):
	selected = _selected
	box.visible = _selected


func _input(event):
	if event.is_action_pressed("RightClick"):
		folow_cursor = true
	if event.is_action_released("RightClick"):
		folow_cursor = false
	if event.is_action_pressed("LevelSpeed"):
		if Game.Speed == 50 and Game.Zoomies >= 100:
			Game.Zoomies -= 100
			Game.incrSpeed(1)
		elif Game.Speed == 75 and Game.Zoomies >= 200:
			Game.Zoomies -= 200
			Game.incrSpeed(2)
		return


func _physics_process(_delta):
	var speed = Game.Speed
	if folow_cursor:
		if selected:
			target = get_global_mouse_position()
			animation.play("Walk Down")
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()
	else:
		animation.stop()
