extends Sprite

export (float) var speed = 100

func _process(delta):
	var direction = int(Input.is_action_pressed("derecha")) - int(Input.is_action_pressed("izquierda"))
	position.x += direction * speed * delta
