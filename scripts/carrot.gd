extends Area2D

var rng = RandomNumberGenerator.new()
var letter = ''
var speed = 100

func _input(event) -> void:
	if event is InputEventKey and event.pressed:
		var input_letter = char(event.keycode).to_lower()
		if input_letter == letter:
			Utils.carrot_collected.emit()
			$carrot.visible = false
			$label.visible = false
			$particle.emitting = true

func _ready() -> void:
	scale = Vector2.ONE * rng.randf_range(0.5, 0.9)
	$carrot.rotation = rng.randf_range(0, 360)
	speed = scale.x * 200

func _process(delta: float) -> void:
	position.y += speed * delta

func _on_particle_finished() -> void:
	queue_free()
