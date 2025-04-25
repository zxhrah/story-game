extends CharacterBody2D


func _ready():
	$AnimatedSprite2D.play("emoting") # or "idle", whatever you name the animation
