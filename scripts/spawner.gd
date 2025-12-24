extends Marker2D

@onready var stompy = get_parent().get_node("stompy")
@onready var rtimer = get_parent().get_node("rabbit_timer")
@onready var sfx = get_parent().get_node("sfx")
@onready var timer = get_parent().get_node("spawn_timer")
@onready var score = get_parent().get_node("CanvasLayer/score")

var carrot = preload("res://assets/carrot.tscn")
var lettuce = preload("res://assets/lettuce.tscn")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	Utils.carrot_collected.connect(carrots)

func carrots() -> void:
	var crnt_frame = stompy.frame
	stompy.play("stomp-eat")
	stompy.frame = crnt_frame
	rtimer.start()
	score.text = pscore()
	sfx.play()

func pscore():
	var s = str(Utils.score)
	while s.length() < 5:
		s = "0" + s
	return s

func _on_timer_timeout() -> void:
	position.x = rng.randi_range(-330, 330)

	if rng.randf() < 0.8:
		var instance = carrot.instantiate()
		get_parent().get_node("ParallaxBackground/carrots").add_child(instance)
		instance.letter = char(rng.randi_range(65, 90) + 32)
		instance.get_node("label").text = instance.letter
		instance.position = position
	else:
		var instance = lettuce.instantiate()
		get_parent().get_node("ParallaxBackground/carrots").add_child(instance)
		instance.letters[0] = char(rng.randi_range(65, 90) + 32)
		instance.letters[1] = char(rng.randi_range(65, 90) + 32)
		instance.get_node("label").text = instance.letters[0] + instance.letters[1]
		instance.position = position

	timer.start(rng.randf_range(0.4, 0.8))

func _on_rabbit_timer_timeout() -> void:
	var crnt_frame = stompy.frame
	stompy.play("stomp")
	stompy.frame = crnt_frame
