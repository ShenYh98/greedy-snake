extends Node2D

@onready var snakeCtrl = $SnakeCtrl
@onready var gameOverPanel = $GameOverPanel
@onready var gamePausePanel = $GamePausePanel

@export var quitButton = Button
@export var restartButton = Button
@export var pauseButton = Button
@export var pauseQuitButton = Button
@export var pauseRestartButton = Button
@export var returnButton = Button
enum STATE {RUN, OVER}
@export var gameState : STATE


func _on_return_button_pressed() -> void:
	print("返回游戏")
	gamePausePanel.visible = false
	snakeCtrl.signal_move.emit(true)


func _on_pause_button_pressed() -> void:
	print("暂停游戏")
	snakeCtrl.signal_move.emit(false)
	gamePausePanel.visible = true


func _on_quit_button_pressed() -> void:
	print("返回开始界面")
	get_tree().change_scene_to_file("res://StartScreen/StartScreen.tscn")


func _on_start_button_pressed() -> void:
	print("重新开始游戏")
	gameOverPanel.visible = false
	gamePausePanel.visible = false
	snakeCtrl.snake.snakeBody.position = Vector2.ZERO
	snakeCtrl.signal_move.emit(true)
	snakeCtrl.signal_clear_body.emit()
	gameState = STATE.RUN


func _ready() -> void:
	print("main game is ready")

	snakeCtrl.position = Vector2(640, 300) # 控制器位置
	gameOverPanel.position = Vector2(365, 170)
	gameOverPanel.visible = false
	gamePausePanel.position = Vector2(365, 170)
	gamePausePanel.visible = false
	
	gameState = STATE.RUN
	
	for i in range(10):
		snakeCtrl.signal_add_body.emit()

	if quitButton:
		# 先断开可能存在的旧连接，避免重复
		if quitButton.pressed.is_connected(_on_quit_button_pressed):
			quitButton.pressed.disconnect(_on_quit_button_pressed)
		quitButton.pressed.connect(_on_quit_button_pressed)
		
	if restartButton:
		if restartButton.pressed.is_connected(_on_start_button_pressed):
			restartButton.pressed.disconnect(_on_start_button_pressed)
		restartButton.pressed.connect(_on_start_button_pressed)
		
	if pauseButton:
		if pauseButton.pressed.is_connected(_on_pause_button_pressed):
			pauseButton.pressed.disconnect(_on_pause_button_pressed)
		pauseButton.pressed.connect(_on_pause_button_pressed)
		
	if pauseQuitButton:
		# 先断开可能存在的旧连接，避免重复
		if pauseQuitButton.pressed.is_connected(_on_quit_button_pressed):
			pauseQuitButton.pressed.disconnect(_on_quit_button_pressed)
		pauseQuitButton.pressed.connect(_on_quit_button_pressed)
		
	if pauseRestartButton:
		if pauseRestartButton.pressed.is_connected(_on_start_button_pressed):
			pauseRestartButton.pressed.disconnect(_on_start_button_pressed)
		pauseRestartButton.pressed.connect(_on_start_button_pressed)
		
	if returnButton:
		if returnButton.pressed.is_connected(_on_return_button_pressed):
			returnButton.pressed.disconnect(_on_return_button_pressed)
		returnButton.pressed.connect(_on_return_button_pressed)


func _process(_delta: float) -> void:
	if gameState ==  STATE.RUN:
		if snakeCtrl.snake.snakeBody.position.x + 640 < 65 || snakeCtrl.snake.snakeBody.position.x + 640 > 1215 :
			snakeCtrl.signal_move.emit(false)
			gameOverPanel.visible = true
			gameState = STATE.OVER
			print("Game Over!!!")
		elif snakeCtrl.snake.snakeBody.position.y + 300 < 60 || snakeCtrl.snake.snakeBody.position.y + 300 > 665 :
			snakeCtrl.signal_move.emit(false)
			gameOverPanel.visible = true
			gameState = STATE.OVER
			print("Game Over!!!")
