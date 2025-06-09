extends StaticBody2D


var totalTime: int = 10000
var currentTime: int
var unitsCount: int = 0

@onready var bar: ProgressBar = $ProgressBar
@onready var shieldBar: ProgressBar = $ShieldProgressBar
@onready var timer: Timer = $Timer


func _ready():
	currentTime = totalTime
	bar.max_value = totalTime


func _process(_delta):
	if currentTime <= 0:
		cat_defeated()

	# Update shield bar to full if shield is active, else zero
	if Game.shield:
		shieldBar.value = shieldBar.max_value
	else:
		shieldBar.visible = Game.shield


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
	if not Game.shield:
		var shopSeed = 1 * unitsCount
		currentTime -= shopSeed
		var tween = get_tree().create_tween()
		tween.tween_property(bar, "value", currentTime, 0.5).set_trans(Tween.TRANS_LINEAR)


func cat_defeated():
	Game.victory(position)
	queue_free()


func start_fighting():
	timer.start()
