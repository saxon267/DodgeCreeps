extends CanvasLayer

signal start_game


##信息显示
func show_message(text):
	$Message.text=text
	$Message.show()
	$Message_Timer.start()
##游戏结束处理
func show_game_over():
	show_message("Game Over")
	await $Message_Timer.timeout#等待计时器超时
	
	$Message.text="Dodge the Creeps!"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$Start_Button.show()
##分数更新
func update_score(score):
	$Score_Label.text=str(score)
	
##Start按钮按下的事件
func _on_start_button_pressed() -> void:
	$Start_Button.hide()
	start_game.emit()
##当计时器超时
func _on_message_timer_timeout() -> void:
	$Message.hide()
