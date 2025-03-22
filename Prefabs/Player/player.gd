extends Area2D

@export var speed:float=400
var screen_size

signal hit#碰撞信号

func _ready() -> void:
	screen_size=get_viewport_rect().size
	hide()
	
func _process(delta: float) -> void:
	
	var velocity=Vector2.ZERO#默认情况下玩家不应该移动
	##输入监测
	if Input.is_action_pressed("move_right"):
		velocity.x+=1
	if Input.is_action_pressed("move_left"):
		velocity.x-=1
	if Input.is_action_pressed("move_down"):
		velocity.y+=1
	if Input.is_action_pressed("move_up"):
		velocity.y-=1
	##动画控制
	if velocity.length()>0:
		velocity=velocity.normalized()*speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	##限制移动出屏幕
	position+=velocity*delta
	position=position.clamp(Vector2.ZERO,screen_size) 
	##控制动画的角色的方向
	if velocity.x!=0:
		$AnimatedSprite2D.animation="walk"
		$AnimatedSprite2D.flip_v=false
		$AnimatedSprite2D.flip_h=velocity.x<0
	elif velocity.y!=0:
		$AnimatedSprite2D.animation="up"
		$AnimatedSprite2D.flip_v=velocity.y>0

func _on_body_entered(_body: Node2D) -> void:
	hide()
	hit.emit()#发送信号
	$CollisionShape2D.set_deferred("disabled",true)#确保不会多次出发hit信号,set_deferred()函数可以自动处理安全地禁用碰撞
	
##开始新游戏时初始化玩家
func start(pos):
	position=pos
	show()
	$CollisionShape2D.disabled=false
