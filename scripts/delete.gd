extends Area2D

@onready var camera = get_parent().get_node("Camera2D")
@onready var healthbar = get_parent().get_node("CanvasLayer/health")
@onready var dmg_effect = get_parent().get_node("CanvasLayer/damage")
@onready var dmg_timer = get_parent().get_node("dmg_timer")
@onready var dmg_sfx = get_parent().get_node("destroy_sfx")
@onready var transition = get_parent().get_node("CanvasLayer/transition/AnimationPlayer")
@onready var bgmusic = get_parent().get_node("AudioStreamPlayer")
var hearts = []
var total_health = 3
var health = 0

func _ready() -> void:
	for i in range(healthbar.get_child_count()):
		var heart = healthbar.get_child(i)
		hearts.append(heart)
	total_health = hearts.size()
	health = hearts.size()

func update_health() -> void:
	var disableamnt = total_health - health
	for i in range(disableamnt):
		hearts[total_health - i - 1].disable()

func _on_area_entered(area:Area2D) -> void:
	health -= 1
	camera.apply_shake()
	dmg_effect.visible = true
	dmg_timer.start()
	dmg_sfx.play()
	if health >= 0:
		update_health()
	if area.is_in_group("carrot"):
		area.particle_start()
	
	if health == 0:
		bgmusic.playing = false
		transition.play("out")

func _on_dmg_timer_timeout() -> void:
	dmg_effect.visible = false

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "out":
		get_tree().change_scene_to_file("res://scenes/end.tscn")
