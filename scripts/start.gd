extends ColorRect

@onready var bgmusic = get_parent().get_parent().get_node("AudioStreamPlayer")

func _input(event) -> void:
	if event is InputEventKey and event.pressed:
		Utils.score = 0
		bgmusic.playing = false
		$AnimationPlayer.play("out")

func _on_animation_finished(anim_name:StringName) -> void:
	if anim_name == "out":
		get_tree().change_scene_to_file("res://scenes/game.tscn")

