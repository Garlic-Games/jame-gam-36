extends CharacterBody3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var speed: float = 5;

func _physics_process(delta):
	# Add the gravity.
	apply_gravity(gravity * delta);
	var direction = get_direction();
	apply_velocity(direction);
	move_and_slide();

func apply_velocity(direction: Vector3) -> void:
	if direction:
		velocity.x = direction.x * speed;
		velocity.z = direction.z * speed;
	else:
		velocity.x = move_toward(velocity.x, 0, speed);
		velocity.z = move_toward(velocity.z, 0, speed);

func get_direction() -> Vector3:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	return direction;

func apply_gravity(gravity: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity;
