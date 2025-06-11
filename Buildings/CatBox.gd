extends StaticBody2D

var mouseEntered: bool = false
@onready var select: Panel = get_node("Selected")
var Selected: bool = false

func _process(delta: float) -> void:
	select.visible = Selected

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		if mouseEntered == true:
			Selected = !Selected
			if Selected	== true:
				Game.spawnUnit(position)

func _on_mouse_entered() -> void:
	mouseEntered = true

func _on_mouse_exited() -> void:
	mouseEntered = false
