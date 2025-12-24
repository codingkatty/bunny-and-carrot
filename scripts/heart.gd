extends TextureRect

@export var is_life = true
@onready var heart_asset = preload("res://assets/heart.png")
@onready var heartbroken_asset = preload("res://assets/heartbreak.png")

func _ready() -> void:
	if is_life:
		texture = heart_asset
	else:
		texture = heartbroken_asset

func disable() -> void:
	is_life = false
	texture = heartbroken_asset
