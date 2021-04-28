extends Node

onready var player = $Player
onready var rng = RandomNumberGenerator.new()
onready var screenSize = get_viewport().get_visible_rect().size

export (PackedScene) var turret_scene:PackedScene

func _ready():
	player.initialize(self)
	_span_turrets(3)
	
func _span_turrets(amount_of_turrets:int):
	for n in amount_of_turrets:
		var new_turret = turret_scene.instance()
		rng.randomize()
		var rndX = rng.randi_range(0, screenSize.x)
		var rndY = rng.randi_range(0, screenSize.y/2)
		new_turret.initialize(Vector2(rndX, rndY), self, player)
		add_child(new_turret)
