extends CharacterBody3D

@export var speed = 5.0
@export var jump_velocity = 4.5
@export var sensitivity = 0.005

@onready var head = $Head
@onready var camera = $Head/Camera
@onready var ray_cast = $Head/Camera/RayCast3D
@onready var selection = $Selection

var inventory = {
	"dirt": 0
}

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# Mouse look logic - always runs but only affects if captured
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _unhandled_input(event):
	# Toggle mouse capture with Esc
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# Click to capture mouse OR interact with world
	if event is InputEventMouseButton and event.pressed:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			handle_interaction(event.button_index)

func handle_interaction(button):
	if !ray_cast.is_colliding(): return
	
	var collider = ray_cast.get_collider()
	if collider is GridMap:
		if button == MOUSE_BUTTON_LEFT:
			# Mine block
			var pos = ray_cast.get_collision_point() - ray_cast.get_collision_normal() * 0.1
			var grid_pos = collider.local_to_map(collider.to_local(pos))
			if collider.get_cell_item(grid_pos) != -1:
				collider.set_cell_item(grid_pos, -1)
				inventory["dirt"] += 1
		
		elif button == MOUSE_BUTTON_RIGHT:
			# Place block
			if inventory["dirt"] > 0:
				var pos = ray_cast.get_collision_point() + ray_cast.get_collision_normal() * 0.1
				var grid_pos = collider.local_to_map(collider.to_local(pos))
				if collider.get_cell_item(grid_pos) == -1:
					collider.set_cell_item(grid_pos, 0)
					inventory["dirt"] -= 1

func _process(_delta):
	# Update selection highlight
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider is GridMap:
			var pos = ray_cast.get_collision_point() - ray_cast.get_collision_normal() * 0.1
			var grid_pos = collider.local_to_map(collider.to_local(pos))
			if collider.get_cell_item(grid_pos) != -1:
				selection.global_position = collider.to_global(collider.map_to_local(grid_pos))
				selection.visible = true
			else:
				selection.visible = false
		else:
			selection.visible = false
	else:
		selection.visible = false

	# Void respawn
	if global_position.y < -50:
		global_position = Vector3(0, 2, 0)
		velocity = Vector3.ZERO

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = jump_velocity

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
