extends Node

onready var player = $Player
onready var background := $Background
onready var turret := $Turret
onready var turret_mid := $TurretMid
onready var star_scene := preload("res://entities/collectibles/Star.tscn")

var star_position := Vector2(1900, 400)

func _ready():
	randomize()
	player.initialize(self)
	turret.initialize(self, turret.position, player, self)
	turret_mid.initialize(self, turret.position, self)
	
	var star = star_scene.instance()
	add_child(star)
	star.set_position(star_position)
	
