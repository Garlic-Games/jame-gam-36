extends CharacterBody3D

@export_group("Player settings")
@export var speed: float = 5.0;
@export var sensitivity : float = 2.0;

@export_group("Gun settings")
@export var rayDistance : float = 50.0;
@export var fireUnitsPerTick : int = 1;
@export var timeBetweenTicks : float = 0.1;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity");

var isFiring : bool = false;
var timerGun : float = 0.0;

func _init():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;


func _input(event):
	if Input.is_action_just_pressed("fire"):
		isFiring = true;
	elif Input.is_action_just_released("fire"):
		isFiring = false;


func _process(delta):
	timerGun += delta;
	
	if isFiring and timerGun >= timeBetweenTicks:
		timerGun = 0.0;
		detect_entity_in_sight();


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
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * sensitivity;
	return direction;


func apply_gravity(gravity: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity;


func detect_entity_in_sight() -> void:
	var ray = PhysicsRayQueryParameters3D.create($PlayerCamera.global_position, $PlayerCamera.global_position - $PlayerCamera.global_transform.basis.z * rayDistance);
	var collision = get_world_3d().direct_space_state.intersect_ray(ray);
	
	if collision:
		if collision.collider.is_in_group("bird"):
			collision.collider.get_parent().add_fire(fireUnitsPerTick);
