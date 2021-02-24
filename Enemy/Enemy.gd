extends KinematicBody2D

var Enemy_Bullet = load("res://Enemy_Bullet/Enemy_Bullet.tscn")
onready var Bullets = get_node("/root/Game/Bullets")
var speed = 3
var ready_to_move = true
var Explosion = load("res://Explosion/Explosion.tscn")
onready var Explosions = get_node("/root/Game/Explosions")

func _ready():
	randomize()

func _physics_process(delta):
	pass

func die(s):
	Global.score += s
	var explosion = Explosion.instance()
	explosion.position = position
	Explosions.add_child(explosion)
	explosion.playing = true
	queue_free()


func _on_Shoot_timeout():
	if randf() < 0.3 and position.y > 0:
		var enemy_bullet = Enemy_Bullet.instance()
		enemy_bullet.position = position
		Bullets.add_child(enemy_bullet)


func _on_Move_timeout():
	if randf() < 0.3 and ready_to_move:
		var new_position = Vector2(randi() % 1024,randi() % 450)
		$Tween.interpolate_property(self, "position", position, new_position, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		ready_to_move = false


func _on_Tween_tween_all_completed():
	ready_to_move = true
