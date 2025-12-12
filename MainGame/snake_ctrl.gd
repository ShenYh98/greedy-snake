extends Control

@onready var snake = $Snake

signal signal_move(value: bool)
signal signal_add_body()
signal signal_clear_body()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("snake ctrl is ready")
	signal_move.connect(snake._move)
	signal_add_body.connect(snake._add_body)
	signal_clear_body.connect(snake._clear_body)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	snake.direction_in = Input.get_vector("left", "right", "up", "down")
