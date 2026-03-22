extends Area2D

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies() #gets character body 2d nodes overlaping in area
	#returns as an array
	
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position) #function available in most 2D nodes

func shoot():
	const PEW_PEW = preload("uid://vlnnaopyegf")
	var new_bullet = PEW_PEW.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
	var flash = preload("uid://c1b2kbuq1if08").instantiate()
	%ShootingPoint.add_child(flash)

func _on_timer_timeout() -> void:
	shoot()
