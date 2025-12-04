extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(720, 520)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.x <= 1050:
		position.x += 1
	else:
		position.x = 720
