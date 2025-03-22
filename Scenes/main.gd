extends Node

@export var mob_scene:PackedScene
var score:int

func _ready() -> void:
	pass


func game_over() -> void:
	$Score_Timer.stop()
	$Mob_Timer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$Death_Sound.play()
	
##新游戏开始
func new_game():
	$Music.play()
	score=0
	$Player.start($Player_Start_Position.position)
	$Start_Timer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs","queue_free")#清除上局游戏的小怪

##敌人生成计时器
func _on_mob_timer_timeout() -> void:
	var mob=mob_scene.instantiate()#创建怪物场景的新实例
	#在Path2D 上选择一个随机位置
	var mob_spawn_location=$Mob_Path/MobSpawnLocation
	mob_spawn_location.progress_ratio=randf()
	#将小怪的位置设置为随机位置
	mob.position=mob_spawn_location.position
	#设置小怪的方向与路径方向垂直
	var direction=mob_spawn_location.rotation+PI/2
	#为方向添加一些随机性
	direction+=randf_range(-PI/4,PI/4)
	mob.rotation=direction
	#为怪物选择速度
	var velocity=Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity=velocity.rotated(direction)
	#通过将怪物添加到主场景中来生成怪物
	add_child(mob)
##主计时器
func _on_start_timer_timeout() -> void:
	$Mob_Timer.start()
	$Score_Timer.start()

func _on_score_timer_timeout() -> void:
	score+=1
	$HUD.update_score(score)
