extends Node

@onready var art_button = $"../artButton"
@onready var player = $"../player"
@onready var dialogue_label = $"../UI/Label"
@onready var choices = $"../UI/Choices"
@onready var choice1_button = $"../UI/Choices/Choice1"
@onready var choice2_button = $"../UI/Choices/Choice2"
var has_pressed_art_before = false


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("player")
	dialogue_label = get_parent().get_node("UI/Label")

	# Disable player movement
	if player.has_method("set_process"):
		player.set_process(false)

	dialogue_label.visible = false
	choices.visible = false

# Function to handle the art button press event
func _on_art_button_pressed() -> void:
	art_button.disabled = true
	if has_pressed_art_before:
		# Second press behavior
		dialogue_label.text = "You ready to go?"
		dialogue_label.visible = true

		# Update Choice1 text and make it visible again
		choice1_button.text = "Yes, Let's Go!"
		choice1_button.visible = true
		choices.visible = true  # Show the choices container again

	else:
		# First press behavior
		has_pressed_art_before = true

		# Make player visible and position it off-screen
		player.visible = true
		player.global_position = Vector2(-100, player.global_position.y)

		# Get the player's AnimatedSprite to play the walking animation
		var animated_sprite = player.get_node("AnimatedSprite2D")
		if animated_sprite:
			print("AnimatedSprite found, playing walking_right animation")
			animated_sprite.play("walking_right")
		else:
			print("Error: AnimatedSprite not found!")

		# Move the player to the target position
		var tween = get_tree().create_tween()
		var walk_target = Vector2(300, player.global_position.y)
		tween.tween_property(player, "global_position", walk_target, 2.0).set_trans(Tween.TRANS_LINEAR)
		tween.tween_callback(Callable(self, "_on_player_arrived"))

func _on_player_arrived():
	# Stop the walking animation and switch to idle
	var animated_sprite = player.get_node("AnimatedSprite2D")  # Assuming AnimatedSprite is a child of player
	
	if animated_sprite:
		print("Player arrived, playing idle animation")
		animated_sprite.play("idle")  # Play idle animation
	else:
		print("Error: AnimatedSprite not found when arriving!")

	dialogue_label.text = "Hi! I'm anwara. This painting is about my story. Want to know more?"
	dialogue_label.visible = true

	# Wait for 2 seconds before showing the choices
	await get_tree().create_timer(2.0).timeout
	choices.visible = true

func _on_choice_1_pressed():
	get_tree().change_scene_to_file("res://scenes/main_game.tscn")


func _on_choice_2_pressed():
	# Hide buttons
	choice1_button.visible = false
	choice2_button.visible = false
	choices.visible = false

	# Show reminder message
	dialogue_label.text = "That's ok! Just let me know if you change your mind."
	dialogue_label.visible = true

	# Wait 5 seconds
	await get_tree().create_timer(3.0).timeout

	# Hide the label
	dialogue_label.visible = false
	
	# Re-enable the art button
	art_button.disabled = false
	
func _process(delta: float) -> void:
	pass
