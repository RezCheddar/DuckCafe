extends Node2D

var object = preload("res://object.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if Input.is_action_just_released("Event"):
		var O=object.instantiate()
		O.initialize(get_global_mouse_position())
		get_tree().current_scene.add_child(O)
