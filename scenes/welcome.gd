extends Control

@onready var view_info = $info
@onready var information = $information
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	SceneTransition.change_scene("res://scenes/gallery.tscn", $AmbientPlayer)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_info_pressed() -> void:
	information.visible = true
	view_info.visible = false
