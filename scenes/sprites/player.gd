extends CharacterBody2D

@onready var footstep_audio = $footstepSFX
@onready var animated_sprite = $AnimatedSprite2D
@onready var boat = $Boat
@onready var boat_left = $Boat/BoatLeft
@onready var boat_right = $Boat/BoatRight

var speed = 100
var last_direction = "right"
var in_scene_4 = false

func _ready():
	var current_scene = get_tree().current_scene
	print("Current scene is: ", current_scene.name)
	if current_scene.name == "scene4":
		in_scene_4 = true
		boat.visible = true   # Show the boat container
		boat_left.visible = false
		boat_right.visible = true
	else:
		print("We are NOT in scene 4!")
		print("Current scene is: ", current_scene.name)

		in_scene_4 = false
		boat.visible = false  # Hide the whole boat outside scene 4

func _physics_process(delta):
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed
	velocity.y = 0

	# Movement and Animation
	if direction > 0:
		if in_scene_4:
			animated_sprite.play("rowing_right")
			last_direction = "right"
		else:
			animated_sprite.play("walking_right")
	elif direction < 0:
		if in_scene_4:
			animated_sprite.play("rowing_left")
			last_direction = "left"
		else:
			animated_sprite.play("walking_left")
	else:
		animated_sprite.play("idle")

	# Footstep Audio
	if not in_scene_4:
		if direction != 0:
			if not footstep_audio.playing:
				footstep_audio.play()
		else:
			footstep_audio.stop()
	else:
		footstep_audio.stop()

	# Boat Image Toggle
	if in_scene_4:
		if last_direction == "right":
			boat_right.visible = true
			boat_left.visible = false
		elif last_direction == "left":
			boat_right.visible = false
			boat_left.visible = true

	move_and_slide()
