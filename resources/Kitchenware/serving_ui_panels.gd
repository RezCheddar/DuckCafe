extends Panel
@onready var log=preload("res://resources/Inventorys/PlayerCookwareIndex.tres")

var mouse=false
var size_x=3
var size_y=3
var amount=1
var ID=0
var dragging
var switch
# Called when the node enters the scene tree for the first time.
func _ready():
	mouse=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("LeftClick")==true&&mouse==true:
		if amount>0:
			dragging=true
			GlobalUi.givePlate=true
			GlobalUi.currentPlateAmount=amount
			give()
	if Input.is_action_just_released("LeftClick"):
		dragging=false
	if dragging==true:
		switch=true
		GlobalUi.currentPlateID=ID
		GlobalUi.currentPlate_SIZEX=size_x
		GlobalUi.currentPlate_SIZEY=size_y
	elif switch==true:
		GlobalUi.currentPlateAmount=0
		GlobalUi.currentPlate_SIZEX=0
		GlobalUi.currentPlate_SIZEY=0
		switch=false

func set_index(n:int):
	ID=n
	$name.text=log.index[n][0].Name
	$Panel/amount.text=str(log.index[n][1])
	$TextureRect.texture=log.index[n][0].Tex
	amount=log.index[n][1]
	size_x=log.index[n][0].Size_x
	size_y=log.index[n][0].Size_y

func _process(delta):
	pass

func update():
	if GlobalUi.currentPlateID==ID:
		amount=GlobalUi.currentPlateAmount
		$Panel/amount.text=str(amount)
func give():
	GlobalUi.currentPlateID=ID
	GlobalUi.currentPlateAmount-=1
	update()

func _on_area_2d_mouse_entered():
	mouse=true




func _on_area_2d_mouse_exited():
	mouse=false
