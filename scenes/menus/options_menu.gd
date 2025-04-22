extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_save_pressed():
	var vbox = $AudioOptions/VBoxContainer
	var save_button = $AudioOptions/Save

	# Toggle visibility and update text accordingly
	if vbox.visible:
		vbox.visible = false
		save_button.text = "⚙️"
		# Apply the volume setting when hiding
		AudioServer.set_bus_volume_db(1, linear_to_db($AudioOptions/VBoxContainer/music.value))
		AudioServer.set_bus_volume_db(2, linear_to_db($AudioOptions/VBoxContainer/sfxslider.value))
	else:
		vbox.visible = true
		save_button.text = "Save"
		
