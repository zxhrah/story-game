extends Control

@onready var save_button = $AudioOptions/Save
@onready var vbox = $AudioOptions/VBoxContainer

# Preload icon
var save_icon = preload("res://assets/other/settings.png")

func _ready() -> void:
	_update_button_appearance()
	save_button.pressed.connect(_on_save_pressed)

func _on_save_pressed():
	vbox.visible = !vbox.visible

	if !vbox.visible:
		AudioServer.set_bus_volume_db(1, linear_to_db($AudioOptions/VBoxContainer/music.value))
		AudioServer.set_bus_volume_db(2, linear_to_db($AudioOptions/VBoxContainer/sfxslider.value))

	_update_button_appearance()

func _update_button_appearance():
	if vbox.visible:
		save_button.text = "Save"
		save_button.icon = null
	else:
		save_button.text = ""
		save_button.icon = save_icon
