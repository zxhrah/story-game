extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished

	var new_scene = load(target)
	get_tree().change_scene_to_packed(new_scene)

	$AnimationPlayer.play_backwards("dissolve")
