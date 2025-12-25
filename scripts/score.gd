extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = pscore()


func pscore():
	var s = str(Utils.score)
	while s.length() < 5:
		s = "0" + s
	return s

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
