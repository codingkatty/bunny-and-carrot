extends Marker2D

@onready var stompy = get_parent().get_node("stompy")
@onready var rtimer = get_parent().get_node("rabbit_timer")

var carrot = preload("res://assets/carrot.tscn")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	Utils.carrot_collected.connect(carrots)

func carrots() -> void:
	var crnt_frame = stompy.frame
	stompy.play("stomp-eat")
	stompy.frame = crnt_frame
	rtimer.start()

func _on_timer_timeout() -> void:
	position.x = rng.randi_range(-330, 330)

	var instance = carrot.instantiate()
	get_parent().get_node("ParallaxBackground/carrots").add_child(instance)
	instance.letter = char(rng.randi_range(65, 90) + 32)
	instance.get_node("label").text = instance.letter
	instance.position = position

func _on_rabbit_timer_timeout() -> void:
	var crnt_frame = stompy.frame
	stompy.play("stomp")
	stompy.frame = crnt_frame
