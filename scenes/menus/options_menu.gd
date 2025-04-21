extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_save_pressed():
	var vbox = $AudioOptions/VBoxContainer
	var save_button = $AudioOptions/Save  # Corrected path since Save is a sibling to VBoxContainer

	# Toggle visibility of VBoxContainer
	vbox.visible = !vbox.visible

	# Change the button text depending on visibility
	if vbox.visible:
		save_button.text = "Save"
	else:
		save_button.text = "Saved"

	# Optional: Save volume when hiding the menu
	if not vbox.visible:
		AudioServer.set_bus_volume_db(1, linear_to_db($AudioOptions/VBoxContainer/music.value))
