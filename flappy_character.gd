extends CharacterBody2D

@export var jump_force: float = -400
@export var gravity: float = 900
@export var death_zone_y: float = 1000  # Y position where player respawns

var start_position: Vector2

func _ready():
	start_position = global_position

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_force
	
	move_and_slide()
	
	# Check if player fell into death zone
	if global_position.y > death_zone_y:
		restart()

# Reset player position and velocity
func restart():
	get_tree().reload_current_scene()
 
# Connect this signal from pipe CollisionShape2D or Area2D
func _on_pipe(body):
	if body == self:
		restart()
