extends Area2D

var rng = RandomNumberGenerator.new()
var letter = ''
var speed = 100
var is_scored = false

func _input(event) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode >= KEY_A and event.keycode <= KEY_Z:
			var input_letter = char(event.keycode).to_lower()
			if input_letter == letter and not is_scored:
				Utils.score += 1
				Utils.carrot_collected.emit()
				particle_start()
				is_scored = true

func _ready() -> void:
	scale = Vector2.ONE * rng.randf_range(0.5, 0.9)
	$carrot.rotation = rng.randf_range(0, 360)
	speed = scale.x * 200

func _process(delta: float) -> void:
	position.y += speed * delta

func particle_start() -> void:
	$carrot.visible = false
	$label.visible = false
	$particle.emitting = true
	call_deferred("disable_collision")

func _on_particle_finished() -> void:
	queue_free()

func disable_collision() -> void:
	$CollisionShape2D.disabled = true
