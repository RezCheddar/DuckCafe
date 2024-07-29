extends StaticBody2D
var stay=true
var mouse=false
var dragging=true
var tiles={}
var switch=true
var T
var C
var Type
@onready var cookwareIndex=preload("res://resources/Inventorys/PlayerCookwareIndex.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.self_modulate=Color(1,1,1,1)
	T=cookwareIndex.index[GlobalUi.currentPlateID][0].Tex
	C=cookwareIndex.index[GlobalUi.currentPlateID][0].collisionShape
	Type=cookwareIndex.index[GlobalUi.currentPlateID][0].Type


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	setexture(T)
	if mouse==true and Input.is_action_just_pressed("LeftClick"):
		dragging=true
	if Input.is_action_just_released("LeftClick"):
		dragging=false
	if dragging==true:
		$Sprite2D.self_modulate=Color(1,1,1,0.27)
		global_position=get_global_mouse_position()
	else:
		$Sprite2D.self_modulate=Color(1,1,1,1)
		if Input.is_action_just_pressed("Event") and mouse==true:
			if Type=="Cup":
				get_tree().change_scene_to_file("res://scenes/DrinkEditor.tscn")

func setexture(t:Texture2D):
	$Sprite2D.texture=t
	$Area2D/CollisionShape2D.shape=C
	

func set_tile(d:Dictionary):
	tiles=d
	pass


func remove():
	GlobalUi.currentPlateAmount-=1
	GlobalUi.update=true
	switch=false
func add():
	GlobalUi.currentPlateAmount+=1
	GlobalUi.update=true
	switch=false



func _on_area_2d_mouse_entered():
	mouse=true



func _on_area_2d_mouse_exited():
	mouse=false
