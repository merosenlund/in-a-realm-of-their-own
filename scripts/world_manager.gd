extends Node3D

@export var grid_map: GridMap
@export var expansion_interval: float = 5.0
@export var block_id: int = 0 # Dirt

var current_radius: float = 3.0
var timer: float = 0.0

func _ready():
	# Initial platform
	generate_realm(current_radius)

func _process(delta):
	timer += delta
	if timer >= expansion_interval:
		timer = 0.0
		expand_realm()

func generate_realm(radius: float):
	for x in range(-int(radius), int(radius) + 1):
		for z in range(-int(radius), int(radius) + 1):
			if Vector2(x, z).length() <= radius:
				grid_map.set_cell_item(Vector3i(x, 0, z), block_id)

func expand_realm():
	var old_radius = current_radius
	current_radius += 0.5
	
	# Fill new area
	var r_int = int(current_radius) + 1
	for x in range(-r_int, r_int):
		for z in range(-r_int, r_int):
			var dist = Vector2(x, z).length()
			if dist <= current_radius and dist > old_radius:
				# Random chance to generate a block
				if randf() > 0.4:
					grid_map.set_cell_item(Vector3i(x, 0, z), block_id)
