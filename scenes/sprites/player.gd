extends CharacterBody2D


var speed = 100
var animated_sprite

func _ready():
	animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed
	velocity.y = 0  # Prevent vertical movement
	
	
	if direction > 0:
		animated_sprite.play("walking_right")
	elif direction < 0:
		animated_sprite.play("walking_left")
	else:
		animated_sprite.play("idle")
	
	move_and_slide()
