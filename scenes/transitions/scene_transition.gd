extends CanvasLayer

func change_scene(target: String, fade_node: AudioStreamPlayer = null) -> void:
	if fade_node:
		var tween = create_tween()
		tween.tween_property(fade_node, "volume_db", -80, 1.0)  # Fade out over 1 second
		await tween.finished

	# Play dissolve transition
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished

	# Change the scene
	get_tree().change_scene_to_file(target)

	# Play transition back in
	$AnimationPlayer.play_backwards("dissolve")
