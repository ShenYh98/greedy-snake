extends Control

@onready var snake = $Snake

signal signal_move(value: bool)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("snake ctrl is ready")
	signal_move.connect(snake._move)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	snake.direction_in = Input.get_vector("left", "right", "up", "down")
