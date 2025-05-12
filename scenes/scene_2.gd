extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player": # if player enters the area 2d
		# Transition to the previous scene is played
		SceneTransition.change_scene("res://scenes/scene_3.tscn")


func _on_entrance_2d_body_entered(body: Node2D) -> void:
	if body.name == "player": # if player enters the area 2d
		# Transition to the next scene is played
		SceneTransition.change_scene("res://scenes/main_game.tscn")
