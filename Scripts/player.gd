extends CharacterBody2D

var pos_record: Array[Vector2] = []
var rewinding: bool

@export_category("COLORS")
@export var normal_color: Color = Color.WHITE
@export var rewind_color: Color = Color.REBECCA_PURPLE

@export_category("MOVEMENT")
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction

func _physics_process(delta):
	if !rewinding:
		modulate = normal_color
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()
	
	else:
		rewind()

func rewind():
	modulate = rewind_color
	if pos_record.size() > 0:
		position = pos_record.pop_back()

func init_rewind(record: Array[Vector2]):
	rewinding = true
	pos_record = record

func end_rewind():
	rewinding = false
	pos_record = []
