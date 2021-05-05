extends KinematicBody2D

onready var cannon = $Cannon
onready var remaining_hits_label = $HitsLabel
onready var game_over_label = $GameOverLabel

export (float) var ACCELERATION:float = 20.0
export (float) var H_SPEED_LIMIT:float = 600.0
export (float) var FRICTION_WEIGHT:float = 0.1
export (float) var GRAVITY:float = 10
export (float) var HITS_TO_DIE:float = 3

var velocity:Vector2 = Vector2.ZERO
var projectile_container
var remaining_hits_text = "Remaining hits:"
var remaining_hits

func initialize(projectile_container):
	self.projectile_container = projectile_container
	cannon.projectile_container = projectile_container
	remaining_hits = HITS_TO_DIE
	remaining_hits_label.text = str(remaining_hits_text, remaining_hits)
	game_over_label.visible = false

func _physics_process(delta):
	
	# Cannon rotation
	var mouse_position:Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)
	
	# Cannon fire
	if Input.is_action_just_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = get_parent()
			cannon.projectile_container = projectile_container
		cannon.fire()
	
	# Player movement
	var h_movement_direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	
	velocity += Vector2.DOWN * GRAVITY
	move_and_slide(velocity, Vector2(0,-1))
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity = Vector2.UP * 400

func notify_hit():
	remaining_hits = clamp(remaining_hits - 1, 0, HITS_TO_DIE)
	remaining_hits_label.text = str(remaining_hits_text, remaining_hits)
	if remaining_hits == 0:
		game_over_label.visible = true
		get_tree().paused = true

func _ready():
	add_to_group("player")
