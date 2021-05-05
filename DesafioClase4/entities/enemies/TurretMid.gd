extends StaticBody2D

onready var fire_position = $FirePosition
onready var fire_timer = $FireTimer

export (PackedScene) var projectile_scene

var projectile_container
var raycast_result

func initialize(container, turret_pos, projectile_container):
	#si la torreta no es hijo ya del container, este se agrega como hijo
	if !container.has_node(self.get_path()):
		container.add_child(self) 
	# global_position = turret_pos
	self.projectile_container = projectile_container
	fire_timer.connect("timeout", self, "fire_at_player")
	fire_timer.start()

func fire_at_player():
	var proj_instance = projectile_scene.instance()
	proj_instance.initialize(
		projectile_container, fire_position.global_position, Vector2.DOWN
	)
