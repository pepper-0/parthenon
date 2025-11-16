extends CharacterBody2D


const SPEED = 800.0
const JUMP_VELOCITY = -500.0

var coin_counter = 0

@onready var coin_label = $"../CanvasLayer/Label"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	

	
	
func set_coin(new_coin_count: int) -> void:
	coin_counter = new_coin_count
	coin_label.text = "Collected Olives: " + str(coin_counter) + "/5"


func _on_coin_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		set_coin(coin_counter + 1)
		print(coin_counter)


func _on_coin_5_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://end/end.tscn")
