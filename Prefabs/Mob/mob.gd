extends RigidBody2D


func _ready() -> void:
	var mob_types=Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation=mob_types.pick_random()#生成时随机选择一个动画


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.
