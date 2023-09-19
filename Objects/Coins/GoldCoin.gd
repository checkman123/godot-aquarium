extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = randf_range(60,100)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
