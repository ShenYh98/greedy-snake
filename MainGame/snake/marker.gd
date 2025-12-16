# Marker.gd
extends Node2D

@onready var sprite = $Sprite2D
var lifetime: float = 10.0  # 标记点存在时间

func _ready():
	# 设置随机颜色以便区分
	var random_color = Color(randf(), randf(), randf())
	sprite.modulate = random_color
	
	# 设置大小
	scale = Vector2(1.0, 1.0)
	
	# 设置定时消失
	var timer = Timer.new()
	timer.wait_time = lifetime
	timer.autostart = true
	timer.timeout.connect(queue_free)
	add_child(timer)

# 显示方向信息
func set_direction(direction: Vector2):
	var direction_text = ""
	var color = Color.WHITE
	
	match direction:
		Vector2.RIGHT:
			direction_text = "→"
			color = Color.RED
		Vector2.LEFT:
			direction_text = "←"
			color = Color.BLUE
		Vector2.UP:
			direction_text = "↑"
			color = Color.GREEN
		Vector2.DOWN:
			direction_text = "↓"
			color = Color.YELLOW
	
	# 创建一个Label显示方向
	var label = Label.new()
	label.text = direction_text
	label.modulate = color
	label.position = Vector2(0, 0)  # 稍微偏移
	add_child(label)
