extends Node2D

@onready var snakeCtrl = $SnakeCtrl


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	snakeCtrl.position = Vector2(640, 300) # x: 1215 65 / y: 60 665


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if snakeCtrl.position.x < 65 && snakeCtrl.position.x > 1215 :
		#snakeCtrl.signal_move(false)
	#elif snakeCtrl.position.y < 60 && snakeCtrl.position.y > 665 :
		#snakeCtrl.signal_move(false)
	pass
