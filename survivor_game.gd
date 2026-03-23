extends Node2D

var score = 0
@onready var kills: Label = %Kills


func spawn_mob():
	var mob = preload("uid://y38gte5o0xf8").instantiate()
	%PathFollow2D .progress_ratio = randf()
	mob.global_position = %PathFollow2D.global_position
	mob.mob_died.connect(_on_mob_mob_died)
	add_child(mob)


func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
	
	await restart_countdown_paused(3)
	
	get_tree().paused = false
	get_tree().reload_current_scene()


func restart_countdown_paused(seconds: int) -> void:
	%Countdown.visible = true
	
	for i in range(seconds, 0, -1):
		%Countdown.text = "Restarting in " + str(i) + "..."
		await get_tree().create_timer(1.0, true, false, true).timeout


func _on_mob_mob_died() -> void:
	print("mob dead")
	score += 1
	kills.text = "Kills: " + str(score)
