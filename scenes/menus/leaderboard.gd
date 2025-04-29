extends Control

@onready var scores_list = $ScoresList
@onready var score_entry_template = $ScoresList/ScoreEntryTemplate

func _ready():
	score_entry_template.visible = false
	await update_leaderboard()  # Call leaderboard fetching on load

func display_scores(scores: Array) -> void:
	# Clear all entries except the template
	for child in scores_list.get_children():
		if child != score_entry_template:
			child.queue_free()

	# Sort scores in descending order (optional - API may return already sorted)
	scores.sort_custom(_sort_by_score_desc)

	# Add each score with rank
	for i in range(scores.size()):
		var score_data = scores[i]
		var entry = score_entry_template.duplicate()
		entry.visible = true
		var player_name = score_data.get("name", "Guest")
		var player_score = score_data.get("score", 0)
		var rank = score_data.get("rank", i + 1)
		entry.text = str(int(rank)) + ". " + player_name + ": " + str(player_score)
		scores_list.add_child(entry)

# Helper function to sort by score descending
func _sort_by_score_desc(a, b):
	return int(b.get("score", 0) - a.get("score", 0))

# Download and display scores
func update_leaderboard() -> void:
	var result = await Leaderboards.get_scores("testinggame-quiz-5tNI", 0, 20)
	var scores = result.get("scores", [])
	display_scores(scores)

func _on_back_button_pressed() -> void:
	visible = false
	get_parent().get_node("leaderboardButton").visible = true
