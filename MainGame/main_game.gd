extends Node2D

@onready var snakeCtrl = $SnakeCtrl
@onready var gameOverPanel = $CanvasLayer/GameOverPanel
@onready var gamePausePanel = $CanvasLayer/GamePausePanel
@onready var snakeFood = $Food

@export var quitButton = Button
@export var restartButton = Button
@export var pauseButton = Button
@export var pauseQuitButton = Button
@export var pauseRestartButton = Button
@export var returnButton = Button
@export var foodRadomX_min : float
@export var foodRadomX_max : float
@export var foodRadomY_min : float
@export var foodRadomY_max : float


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
	snakeCtrl.signal_clear_body.emit()
	snakeCtrl.signal_add_body.emit()
	snakeCtrl.signal_move.emit(true)
	snakeCtrl.signal_game_start.emit()
	
	var rng = RandomNumberGenerator.new()
	var random_x = rng.randf_range(foodRadomX_min, foodRadomX_max)
	var random_y = rng.randf_range(foodRadomY_min, foodRadomY_max)
	snakeFood.position = Vector2(random_x, random_y)


func _on_collision_occurred(body: Node2D) -> void:
	print("蛇身发生碰撞，对象: ", body.name)
	if body.name == "Food":
		var rng = RandomNumberGenerator.new()
		var random_x = rng.randf_range(foodRadomX_min, foodRadomX_max)
		var random_y = rng.randf_range(foodRadomY_min, foodRadomY_max)
		snakeFood.position = Vector2(random_x, random_y)
		
		snakeCtrl.signal_add_body.emit() # 创建一个蛇身
	elif body.name == "SnakeBody" || body.name.contains("@Area2D@"):
		snakeCtrl.signal_move.emit(false)
		snakeCtrl.signal_game_over.emit()
		gameOverPanel.visible = true
		print("Game Over!!!")


func _on_collision_ended(body: Node2D) -> void:
	print("蛇身离开区域，对象: ", body.name)
	if body.name == "playArea":
		snakeCtrl.signal_move.emit(false)
		snakeCtrl.signal_game_over.emit()
		gameOverPanel.visible = true
		print("Game Over!!!")


func _ready() -> void:
	print("main game is ready")

	snakeCtrl.position = Vector2(640, 300) # 控制器位置
	gameOverPanel.position = Vector2(365, 170)
	gameOverPanel.visible = false
	gamePausePanel.position = Vector2(365, 170)
	gamePausePanel.visible = false
	
	foodRadomX_min = 160.0
	foodRadomX_max = 1995.0
	foodRadomY_min = 160.0
	foodRadomY_max = 1100.0

	# 食物位置随机生成
	var rng = RandomNumberGenerator.new()
	var random_x = rng.randf_range(foodRadomX_min, foodRadomX_max)
	var random_y = rng.randf_range(foodRadomY_min, foodRadomY_max)
	snakeFood.position = Vector2(random_x, random_y)

	# 默认要有一个蛇头
	snakeCtrl.signal_add_body.emit()

	# 蛇头蛇身碰撞信号
	snakeCtrl.snake.snakeBody.collision_occurred.connect(_on_collision_occurred)
	# 游戏区域碰撞信号
	snakeCtrl.snake.snakeBody.collision_ended.connect(_on_collision_ended)

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
