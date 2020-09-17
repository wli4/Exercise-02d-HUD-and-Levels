extends KinematicBody2D


export var speed = 3

func _physics_process(delta):
	position.y += speed
	if position.y > get_viewport().size.y + 100:
		queue_free()
