extends Area2D

var travelled_distance = 0


func _physics_process(delta: float) -> void:
	const SPEED = 1000.0
	const MAX_RANGE = 1200.0
	
	var direction = Vector2.RIGHT.rotated(rotation)
	#Vector2 used to construction coordinates
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	
	if travelled_distance >= MAX_RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		var impact = preload("uid://kcl4efkvrany").instantiate()
		get_parent().add_child(impact)
		impact.global_position = global_position
		impact.global_rotation = global_rotation
		body.take_damage()
	queue_free()
