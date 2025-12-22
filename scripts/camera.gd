extends Camera2D

@onready var timer = get_parent().get_node("cam_timer")

func _ready() -> void:
	Utils.carrot_collected.connect(bop)

func bop() -> void:
	var tween = create_tween()
	tween.tween_property(self, "zoom", zoom * 1.1, 0.1)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_cam_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "zoom", Vector2.ONE, 0.1)
