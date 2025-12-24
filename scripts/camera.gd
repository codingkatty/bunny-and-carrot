extends Camera2D

@onready var timer = get_parent().get_node("cam_timer")

var randomStrength: float = 20.0
var shakeFade: float = 5.0
var shake_strength: float = 0.0
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	Utils.carrot_collected.connect(bop)

func bop() -> void:
	$AnimationPlayer.stop()
	var tween = create_tween()
	tween.tween_property(self, "zoom", zoom * 1.1, 0.1)
	timer.start()

func apply_shake():
	shake_strength = randomStrength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
	offset = Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

func _on_cam_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "zoom", Vector2(1.03, 1.03), 0.05)

func _on_rabbit_timer_timeout() -> void:
	$AnimationPlayer.play("cam_bop")
