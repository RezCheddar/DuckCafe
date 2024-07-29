extends Sprite2D
@export var counterType:int
@onready var log=preload("res://resources/Inventorys/PlayerCookwareIndex.tres")
var mouse=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):
	if Input.is_action_just_pressed("LeftClick") && mouse==true:
			get_tree().change_scene_to_file("res://server_counter.tscn")

func _on_area_2d_mouse_entered():
	mouse=true




func _on_area_2d_mouse_exited():
	mouse=false

