extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.velocity.y > 0:
			body.jump()
