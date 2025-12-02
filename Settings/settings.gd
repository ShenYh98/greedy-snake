extends Control

# 1. 定义常量
const CONFIG_PATH = "user://game_settings.cfg"
const MUSIC_BUS_NAME = "Master"

# 2. 导出变量 - 添加了TextureRect引用
@export var music_on_button: Button
@export var music_off_button: Button
@export var back_button: Button
@export var music_icon: TextureRect  # 新增：引用图标显示节点

# 3. 预加载两个图标资源（请确保路径正确）
@onready var volume_on_icon = preload("res://Settings/musicOn.svg")
@onready var volume_off_icon = preload("res://Settings/musicOff.svg")

func _ready():
	# 连接按钮信号
	if music_on_button:
		music_on_button.pressed.connect(_on_music_on_button_pressed)
	if music_off_button:
		music_off_button.pressed.connect(_on_music_off_button_pressed)
	if back_button:
		back_button.pressed.connect(_on_back_button_pressed)
	
	print(ProjectSettings.globalize_path("user://"))
	
	# 加载设置
	_load_settings()
	# 更新按钮和图标状态
	_update_ui_state()

# 4. 点击"打开音乐"按钮
func _on_music_on_button_pressed():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(MUSIC_BUS_NAME), 0.0)
	_save_settings(true)
	_update_ui_state()

# 5. 点击"关闭音乐"按钮
func _on_music_off_button_pressed():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(MUSIC_BUS_NAME), -80.0)
	_save_settings(false)
	_update_ui_state()

# 6. 点击"返回"按钮
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://StartScreen/StartScreen.tscn")

# 7. 更新UI状态（按钮和图标）
func _update_ui_state():
	# 获取当前音量状态
	var current_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index(MUSIC_BUS_NAME))
	var is_music_on = current_volume > -40.0
	
	# 更新按钮状态
	if music_on_button:
		music_on_button.button_pressed = is_music_on
	if music_off_button:
		music_off_button.button_pressed = not is_music_on
	
	# 更新图标 - 根据音乐状态切换显示的图片
	if music_icon:
		if is_music_on:
			music_icon.texture = volume_on_icon
		else:
			music_icon.texture = volume_off_icon

# 8. 保存设置
func _save_settings(music_enabled: bool):
	var config = ConfigFile.new()
	config.set_value("audio", "music_enabled", music_enabled)
	config.save(CONFIG_PATH)

# 9. 加载设置
func _load_settings():
	var config = ConfigFile.new()
	var err = config.load(CONFIG_PATH)
	
	if err == OK:
		var music_enabled = config.get_value("audio", "music_enabled", true)
		if music_enabled:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index(MUSIC_BUS_NAME), 0.0)
		else:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index(MUSIC_BUS_NAME), -80.0)
