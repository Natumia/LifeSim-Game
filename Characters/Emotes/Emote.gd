extends AnimatedSprite

signal emote_done

func _ready():
	playing = true

func _on_Timer_timeout():
	emit_signal("emote_done")
	queue_free()
