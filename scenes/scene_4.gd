extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_entrance_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		SceneTransition.change_scene("res://scenes/scene_3.tscn")


func _on_exit_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		SceneTransition.change_scene("res://scenes/quiz.tscn")
