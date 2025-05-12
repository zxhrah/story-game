extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
# signal
func _on_close_button_pressed() -> void:
	visible = false # Hides UI
	get_parent().get_node("info").visible = true # Displays the information
