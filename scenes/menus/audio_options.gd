extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Converts the decibels to linear scale so it is more accurate
	$VBoxContainer/music.value = db_to_linear(AudioServer.get_bus_volume_db(1)) #Cusic bus
	$VBoxContainer/sfxslider.value = db_to_linear(AudioServer.get_bus_volume_db(2)) #Sfx bus

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_h_slider_mouse_exited():
	release_focus() # Removes the focus from slider so it is not accidentally pressed

func _on_sfxslider_mouse_exited() -> void:
	release_focus() # Ensures slider does not keep focus
