extends Node3D

# TODO: a primtive placing algorithm

# TODO: fix centering
# TODO: fix the intersection issue
# TODO: UI and debug profiles
# TODO: fix the directory naming issue
# TODO: rust impl
# TODO: spread out the code
# TODO: tidy the github repo 


var voxel_data: Array

var bounding_box: Vector3 = Vector3i(10,10,10)
@export var grid_size:float
var center :=  Vector3i.ZERO 



# Called when the node enters the scene tree for the first time.
func _ready():
	

	var steps_x = int(bounding_box.x / grid_size)
	var steps_y = int(bounding_box.y / grid_size)
	var steps_z = int(bounding_box.z / grid_size)

	for x in range(steps_x):
		for y in range(steps_y):
			for z in range(steps_z):
				var pos = Vector3(x * grid_size, y * grid_size, z * grid_size)

				voxel_data.append({
				"position": pos
			})
				
				

func ifisinsidemesh(pos):
	var raycat = PhysicsRayQueryParameters3D.create(pos, Vector3.DOWN * 0.3 )
	
	var result = get_world_3d().direct_space_state.intersect_ray(raycat)
	
	raycat.hit_back_faces = true
	raycat.hit_from_inside  = true
	
	
	return result.size() % 2 == 0
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var active_voxel_data: Array

	for i in voxel_data:
		if ifisinsidemesh(i.position):
			
			DebugDraw.draw_cube(i.position,grid_size)
