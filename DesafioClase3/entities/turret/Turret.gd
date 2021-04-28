extends Sprite

onready var fire_position = $Fire_position

export (PackedScene) var projectile_scene:PackedScene

var container:Node
var player:Node

func initialize(random_position:Vector2, span_container:Node, player_node:Node):
	position = random_position
	container = span_container
	player = player_node

func _on_FireTimer_timeout():
	var new_projectile = projectile_scene.instance()
	container.add_child(new_projectile)
	new_projectile.initialize((player.global_position - fire_position.global_position).normalized(), fire_position.global_position)
