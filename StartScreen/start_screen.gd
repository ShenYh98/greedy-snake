extends Control

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
	# 检查并连接每个按钮的 pressed 信号到对应的处理函数
	if start_button:
		start_button.pressed.connect(_on_start_button_pressed)
	if settings_button:
		settings_button.pressed.connect(_on_settings_button_pressed)
	if quit_button:
		quit_button.pressed.connect(_on_quit_button_pressed)
