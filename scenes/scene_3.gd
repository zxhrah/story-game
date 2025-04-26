extends Node2D

@onready var cow_audio = $cow/cowAudio
@onready var moo_timer = $cow/cowAudio/MooTimer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_entrance_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		SceneTransition.change_scene("res://scenes/scene_2.tscn")


func _on_exit_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		SceneTransition.change_scene("res://scenes/scene_4.tscn")

func _moo():
	if not cow_audio.playing:
		cow_audio.play()
		# After the cow sound finishes, wait 8 seconds
		moo_timer.start(10.0)

func _on_moo_timer_timeout() -> void:
	_moo()
