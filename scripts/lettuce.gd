extends Area2D

var rng = RandomNumberGenerator.new()
var letters = ['', '']
var crnt_letter = 0
var speed = 100

func _input(event) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode >= KEY_A and event.keycode <= KEY_Z:
			var input_letter = char(event.keycode).to_lower()
			if input_letter == letters[crnt_letter]:
				if crnt_letter == letters.size() - 1:
					Utils.carrot_collected.emit()
					Utils.score += 2
					particle_start()
					return
				else:
					crnt_letter += 1
					update_label()

func update_label() -> void:
	if crnt_letter == 1:
		$label.text = ' ' + letters[1]
	else:
		$label.text = letters[0] + letters[1]

func _ready() -> void:
	scale = Vector2.ONE * rng.randf_range(0.5, 0.9)
	$lettuce.rotation = rng.randf_range(0, 360)
	speed = scale.x * 150

func _process(delta: float) -> void:
	position.y += speed * delta

func particle_start() -> void:
	$lettuce.visible = false
	$label.visible = false
	$particle.emitting = true
	call_deferred("disable_collision")

func _on_particle_finished() -> void:
	queue_free()

func disable_collision() -> void:
	$CollisionShape2D.disabled = true
