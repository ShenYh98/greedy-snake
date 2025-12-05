extends Node2D

@onready var snakeCtrl = $SnakeCtrl


func restart_game() -> void:
	pass


func _ready() -> void:
	snakeCtrl.position = Vector2(640, 300) # 控制器位置


func _process(delta: float) -> void:
	# 蛇的位置相对于控制器是(0, 0)，要做偏移
	if snakeCtrl.snake.position.x + 640 < 65 || snakeCtrl.snake.position.x + 640 > 1215 :
		snakeCtrl.signal_move.emit(false)
	elif snakeCtrl.snake.position.y + 300 < 60 || snakeCtrl.snake.position.y + 300 > 665 :
		snakeCtrl.signal_move.emit(false)
