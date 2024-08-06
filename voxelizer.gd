extends Node3D


var voxel_data: Array

var bounding_box: Vector3i = Vector3i(10,10,10)
@export var grid_size:float
var center :=  Vector3i.ZERO 



# Called when the node enters the scene tree for the first time.
func _ready():
	

	var steps_x = int(bounding_box.x - center.x)
	var steps_y = int(bounding_box.y - center.y)
	var steps_z = int(bounding_box.z - center.z)

	for x in range(steps_x):
		for y in range(steps_y):
			for z in range(steps_z):
				var pos = Vector3(x * grid_size, y * grid_size, z * grid_size)

				voxel_data.append({
				"position": pos
			})
				
				

func ifisinsidemesh(pos):
	var raycat = PhysicsRayQueryParameters3D.create(pos, Vector3.DOWN * grid_size )
	
	var result = get_world_3d().direct_space_state.intersect_ray(raycat)
	
	raycat.hit_back_faces = true
	raycat.hit_from_inside  = true
	
	return result.size() % 2 == 1
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in voxel_data:
		if ifisinsidemesh(i.position):
			print(i)
			DebugDraw.draw_cube(i.position,grid_size)
