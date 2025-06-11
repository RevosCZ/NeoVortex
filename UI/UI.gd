extends CanvasLayer

@onready var honor: Label = $Honor
@onready var treats: Label = $Treats
@onready var zoomies: Label = $Zoomies
@onready var controls: Label = $Controls
@onready var controls2: Label = $Controls2

func _process(delta):
	honor.text = "Honor: " + str(Game.Honor)
	treats.text = "Treats: " + str(Game.Treats)
	zoomies.text = "Zoomies: " + str(Game.Zoomies)
	controls.text = "Hold LMB to select | Click RMB to move selected units | Click LMB on CatBox | S to increase speed (L1: 100Z L2: 200Z)"
	controls2.text = "B to build a TreeHouse (5H) | C to build a SpeedHouse (200T) | A to build an Altar (1000T & 100Z) | Scroll to Zoom"
	
