extends Node

@onready var spawn = preload("res://Global/spawn_unit.tscn")
@onready var altar = preload("res://Global/altarScrpt.tscn")
@onready var intro = preload("res://Global/int.tscn")
@onready var winnerCond = preload("res://Global/victory.tscn")
var is_spawn_unit_open: bool = false
var is_altar_open: bool = false
var is_introduction_open: bool = false
var is_victory_open: bool = false
var shield: bool = true

var Honor = 0
var Treats = 0
var Zoomies = 0
var Speed = 50

func introduction(pos):
	if is_introduction_open:
		return
	
	var path = get_tree().get_root().get_node("World/UI")
	var introduct = intro.instantiate()
	introduct.housePos = pos
	path.add_child(introduct)
	is_introduction_open = true

func spawnUnit(pos):
	if is_spawn_unit_open:
		return
	
	var path = get_tree().get_root().get_node("World/UI")
	var spawnUnit = spawn.instantiate()
	spawnUnit.housePos = pos
	path.add_child(spawnUnit)
	is_spawn_unit_open = true
	
func altarShield(pos):
	if is_altar_open:
		return
	
	var path = get_tree().get_root().get_node("World/UI")
	var AltarUI = altar.instantiate()
	AltarUI.housePos = pos
	path.add_child(AltarUI)
	is_altar_open = true

func victory(pos):
	var path = get_tree().get_root().get_node("World/UI")
	var winner = winnerCond.instantiate()
	winner.housePos = pos
	path.add_child(winner)
	is_victory_open = true

func close_spawn_unit() -> void:
	is_spawn_unit_open = false
	
func close_altar() -> void:
	is_altar_open = false
	
func close_introduction() -> void:
	is_introduction_open = false

func incrSpeed(level):
	if level == 1:
		Game.Speed += 25
	elif Game.Speed == 75 and level == 2:
		Game.Speed += 25
