extends StaticBody2D


var totalTime: int = 5
var currentTime: int
var unitsCount: int = 0

@onready var bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	currentTime = totalTime
	bar.max_value = totalTime


func _process(_delta):
	if currentTime <= 0:
		audio.play()
		audio.connect("finished", Callable(self, "cat_defeated"))
		set_process(false)



func _on_kill_area_body_entered(body):
	if "Char" in body.name:
		unitsCount += 1
		start_fighting()


func _on_kill_area_body_exited(body):
	if "Char" in body.name:
		unitsCount -= 1
		if unitsCount <= 0:
			timer.stop()


func _on_timer_timeout():
	var shopSeed = 1 * unitsCount
	currentTime -= shopSeed
	audio.play()
	var tween = get_tree().create_tween()
	tween.tween_property(bar, "value", currentTime, 0.5).set_trans(Tween.TRANS_LINEAR)


func cat_defeated():
	Game.Honor += 1
	queue_free()


func start_fighting():
	timer.start()
