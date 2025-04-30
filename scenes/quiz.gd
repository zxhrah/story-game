extends Control

@onready var question_board = $questionBoard
@onready var player_name_input = $playerNameInput
@onready var submit_name_button = $submitNameButton
@onready var start_quiz_button = $startQuizButton
@onready var view_leaderboard_button = $leaderboardButton
@onready var leaderboard = $Leaderboard
@onready var gallery = $BacktoGallery
@onready var option_a = $optionA
@onready var option_b = $optionB
@onready var option_c = $optionC
@onready var option_d = $optionD

var leaderboard_instance: Control = null

var quiz_questions = []
var current_question_index = 0
var score = 0
var quiz_active = false

var welcome_messages = [
	"Welcome to the Quiz!",
	"It's time to test your memory.",
	"You must submit an answer for each question.",
	"Your total score will be displayed at the end.",
	"Are you ready?"
]

var message_index = 0

func _ready() -> void:
	# Initially hide the input elements
	player_name_input.visible = false
	submit_name_button.visible = false
	
	show_next_message()

func show_next_message():
	if message_index < welcome_messages.size():
		question_board.text = welcome_messages[message_index]
		message_index += 1
		await get_tree().create_timer(3.0).timeout
		show_next_message()
	else:
		# After all welcome messages, show name input and submit button
		player_name_input.visible = true
		submit_name_button.visible = true
		question_board.text = "Please enter your name below:"
		
func _process(delta: float) -> void:
	pass


func _on_option_a_pressed() -> void:
	if not quiz_active:
		return
	check_answer("A")
	option_a.button_pressed = false  # Reset pressed state


func _on_option_b_pressed() -> void:
	if not quiz_active:
		return
	check_answer("B")
	option_b.button_pressed = false  # Reset pressed state


func _on_option_c_pressed() -> void:
	if not quiz_active:
		return
	check_answer("C")
	option_c.button_pressed = false  # Reset pressed state

func _on_option_d_pressed() -> void:
	if not quiz_active:
		return
	check_answer("D")
	option_d.button_pressed = false  # Reset pressed state

func _on_submit_name_button_pressed() -> void:
	var player_name = player_name_input.text.strip_edges()
	
	if player_name == "":
		# If no name entered, ask again
		question_board.text = "Please enter your name before continuing!"
	else:
		# Save to Global so leaderboard can use it
		Global.player_name = player_name
		
		# Hide name input elements
		player_name_input.visible = false
		submit_name_button.visible = false
		question_board.text = "Let's Start!"
		
		# Show start quiz button
		start_quiz_button.visible = true


func _on_start_quiz_button_pressed() -> void:
	start_quiz_button.visible = false
	begin_quiz()
func begin_quiz():
	# Set up questions
	quiz_questions = [
		{
			"question": "What happened to the weather that caused the roads to be covered with water?",
			"options": ["Overflowing fish pond", "Heavy downpour", "Flooded river", "Sinking ground"],
			"correct": "B"
		},
		{
			"question": "What overflowed causing villagers to cast nets everywhere?",
			"options": ["Fish Pond", "The streets", "Roads", "Rivers"],
			"correct": "A"
		},
		{
			"question": "What else was affected by these floods?",
			"options": ["The animals", "The fields", "The People", "All of the Above"],
			"correct": "D"
		},
		{
			"question": "The floods caused power cuts where there was electricity, and swallowed the roads. How do the residents get around?",
			"options": ["Cars", "Swimming", "Boats", "Walking"],
			"correct": "C"
		},
		{
			"question": "What country is Moulvibazar in?",
			"options": ["Bulgaria", "Beirut", "Bangladesh", "India"],
			"correct": "C"
		}
	]
	
	current_question_index = 0
	score = 0
	Global.score = 0  # <-- reset here too
	quiz_active = true
	
	show_question()
func show_question():
	if current_question_index >= quiz_questions.size():
		end_quiz()
		return
	
	var current_question = quiz_questions[current_question_index]
	
	question_board.text = current_question["question"]
	
	option_a.text = "A) " + current_question["options"][0]
	option_b.text = "B) " + current_question["options"][1]
	option_c.text = "C) " + current_question["options"][2]
	option_d.text = "D) " + current_question["options"][3]
	
	option_a.visible = true
	option_b.visible = true
	option_c.visible = true
	option_d.visible = true
func check_answer(selected_option: String):
	var correct_answer = quiz_questions[current_question_index]["correct"]
	
	if selected_option == correct_answer:
		score += 1          # <-- update local score
		Global.score = score  # <-- sync Global score too
		# Optional: flash green or sound effect here!
	
	current_question_index += 1
	show_question()
func end_quiz():
	quiz_active = false
	
	option_a.visible = false
	option_b.visible = false
	option_c.visible = false
	option_d.visible = false
	
	question_board.text = "Quiz Over!\nYou scored " + str(score) + " out of " + str(quiz_questions.size()) + "!"
	
	await Leaderboards.post_guest_score("testinggame-quiz-5tNI", Global.score, Global.player_name) #posts score online
	view_leaderboard_button.visible = true
	gallery.visible = true

func _on_leaderboard_button_pressed() -> void:
	leaderboard.visible = true
	leaderboard.update_leaderboard()
	view_leaderboard_button.visible = false
	if view_leaderboard_button.visible:
		gallery.visible = false


func _on_backto_gallery_pressed() -> void:
	SceneTransition.change_scene("res://scenes/gallery.tscn")
