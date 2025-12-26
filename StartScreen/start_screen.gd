extends Control

@onready var start_screen_title = $Title
@export var title_speed: float = 80.0

@onready var start_screen_btns = $MenuContainer
@export var start_screen_btns_speed: float = 200.0

@onready var snakesAnimated = $SnakesAnimated
@export var snakesAnimated_speed:float = 200.0

@export var start_button: Button
@export var settings_button: Button
@export var quit_button: Button


# 当“开始游戏”按钮被按下
func _on_start_button_pressed() -> void:
	# 切换到游戏主场景，请将路径替换为你的实际游戏场景文件路径
	print("开始游戏")
	get_tree().change_scene_to_file("res://MainGame/MainGame.tscn")


# 当“设置”按钮被按下
func _on_settings_button_pressed() -> void:
	# 切换到设置场景，请将路径替换为你的实际设置场景文件路径
	print("打开设置")
	get_tree().change_scene_to_file("res://Settings/Settings.tscn")


# 当“退出游戏”按钮被按下
func _on_quit_button_pressed() -> void:
	# 退出游戏
	get_tree().quit()


func _ready() -> void:
	if !GlobalState.is_load:
		start_screen_title.position = Vector2(480, -70)
		start_screen_btns.position = Vector2(-400, 425)
		snakesAnimated.position = Vector2(200, 485)
		snakesAnimated.play("snakes")
	else:
		start_screen_title.position = Vector2(480, 114)
		start_screen_btns.position = Vector2(70, 425)
		snakesAnimated.position = Vector2(850, 485)
		snakesAnimated.play("snakes2")

	# 检查并连接每个按钮的 pressed 信号到对应的处理函数
	if start_button:
		start_button.pressed.connect(_on_start_button_pressed)
	if settings_button:
		settings_button.pressed.connect(_on_settings_button_pressed)
	if quit_button:
		quit_button.pressed.connect(_on_quit_button_pressed)


func _process(delta: float) -> void:
	if snakesAnimated.position.x <= 850:
		snakesAnimated.position += Vector2.RIGHT * snakesAnimated_speed * delta
	else:
		snakesAnimated.play("snakes2")

		if start_screen_title.position.y < 114:
			start_screen_title.position +=  Vector2.DOWN * title_speed * delta
			
		if start_screen_btns.position.x < 70:
			start_screen_btns.position += Vector2.RIGHT * start_screen_btns_speed * delta
			
		if start_screen_title.position.y >= 114 && start_screen_btns.position.x >= 70:
			GlobalState.is_load = true
