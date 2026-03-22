extends CharacterBody2D

signal mob_died

var health = 3


#annotation shorthand for ready function:
@onready var player = get_node("/root/Game/Player")
#Gauruntees given node and all children have been created
#func _ready():
	#player = get_node("/root/Game/Player")

func _ready():
	%Slime.play_walk()


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage():
	$Slime.play_hurt()
	health -= 1
	if health == 0:
		const SMOKE_EXPLOSION = preload("uid://dhmhmrth6rdce")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		queue_free()
		mob_died.emit()
