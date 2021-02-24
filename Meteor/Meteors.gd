extends Node2D

var max_meteors = 2
var Meteor = load("res://Meteor/Meteor.tscn")

func _ready():
	randomize()
	
func _physics_process(delat):
	if get_child_count() < max_meteors:
		if randf() < 0.05:
			var meteor = Meteor.instance()
			meteor.position.y = -100
			meteor.position.x = randi() % 1024
			add_child(meteor)
