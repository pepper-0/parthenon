class_name Player extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -500.0

var coin_counter = 0

@onready var coin_label = $"../CanvasLayer/Label"

func _ready():
	print("Coin label:", coin_label)
	coin_label.visible = true
	coin_label.text = "Money: $0"

func set_coin(new_coin_count: int) -> void:
	coin_counter += new_coin_count
	coin_label.text = "Money: $" + str(coin_counter)

func _physics_process(delta: float) -> void:
		if not is_on_floor():
			velocity += get_gravity() * delta
			
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			
		var direction := Input.get_axis("left", "right")
		
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		move_and_slide()
