extends Camera3D


var Sens: float = 0.3

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func  _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * Sens))
		$".".rotation.x += deg_to_rad(-event.relative.y * Sens)
		$".".rotation.x = clamp($".".rotation.x , deg_to_rad(-89), deg_to_rad(89))
		

