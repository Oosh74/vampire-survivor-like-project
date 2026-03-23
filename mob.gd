extends CharacterBody2D

signal mob_died

var health = 3

@onready var mob_damage: AudioStreamPlayer2D = $MobDamage
@onready var mob_died_sfx: AudioStreamPlayer2D = $MobDied

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
	mob_damage.play()
	health -= 1
	if health == 0:
		mob_died_sfx.reparent(get_parent())
		mob_died_sfx.global_position = global_position
		mob_died_sfx.play()
		mob_died_sfx.finished.connect(mob_died_sfx.queue_free)
		const SMOKE_EXPLOSION = preload("uid://dhmhmrth6rdce")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		queue_free()
		mob_died.emit()
