extends CharacterBody2D

var pos_record: Array[Vector2] = []
var rewinding: bool = false

@export_category("COLORS")
@export var normal_color: Color = Color.RED
@export var rewind_color: Color = Color.WEB_PURPLE

@export_category("MOVEMENT")
@export var SPEED = 100.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if !rewinding:
		modulate = normal_color
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Vector2(1,0).normalized()
		velocity.x = direction.x * SPEED
		#position += velocity
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
