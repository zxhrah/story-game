extends CharacterBody2D

@onready var footstep_audio = $footstepSFX  # Reference the AudioStreamPlayer2D
var speed = 100
var animated_sprite

func _ready():
	animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed
	velocity.y = 0  # Prevent vertical movement

	# Play animation based on direction
	if direction > 0:
		animated_sprite.play("walking_right")
	elif direction < 0:
		animated_sprite.play("walking_left")
	else:
		animated_sprite.play("idle")

	# Play/stop footstep sound
	if direction != 0:
		if not footstep_audio.playing:
			footstep_audio.play()
	else:
		footstep_audio.stop()

	move_and_slide()
