extends Area2D

# 自定义信号
signal collision_occurred(body: Node2D)
signal collision_started(body: Node2D)
signal collision_ended(body: Node2D)

@onready var animatedSnake = $AnimatedSnake


func _ready() -> void:
	# 连接内置信号
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

	animatedSnake.play("AnimatedSnake")


func _on_body_entered(body: Node2D) -> void:
	print("物理进入: ", body.name)
	collision_occurred.emit(body)
	collision_started.emit(body)


func _on_body_exited(body: Node2D) -> void:
	print("物理离开: ", body.name)
	collision_ended.emit(body)


func _on_area_entered(area: Area2D) -> void:
	print("区域进入: ", area.name)
	collision_occurred.emit(area)
	collision_started.emit(area)


func _on_area_exited(area: Area2D) -> void:
	print("区域离开: ", area.name)
	collision_ended.emit(area)
