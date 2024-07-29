extends TileMap
@export var grid_size_x=4
@export var grid_size_y=4
@export var dimentions=[2,5]
@export var dic={} #dictionary
var fulldic={}
var i:float
var s:String
var offset=5
@export var cellState:Array
var count=0
var count2=0
var width=dimentions[0]
var height=dimentions[1]
var valid:bool
var setting:bool=true
var giving=false
@onready var log=preload("res://resources/Inventorys/PlayerCookwareIndex.tres")
@onready var item=preload("res://resources/Kitchenware/kitchen_ware.tscn")
var plate
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalUi.currentPlate_SIZEX=0
	GlobalUi.currentPlate_SIZEY=0
	GlobalUi.currentPlateAmount=0
	position=Vector2(467,261)
	count2=0
	for x in grid_size_x:
		for y in grid_size_y:
			count2+=1
			dic[str(Vector2(x,y))]={
				"Type":"empty"
			}
			cellState.resize(cellState.size()+1)
			var A=[x,y,"empty"]
			cellState[-1]=A
			set_cell(0,Vector2(x,y),2,Vector2i(0,0),0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var countX=-(width-1)/2
	var countY=-(height-1)/2
	dimentions[0]=GlobalUi.currentPlate_SIZEX
	dimentions[1]=GlobalUi.currentPlate_SIZEY
	if GlobalUi.givePlate==false:
		GlobalUi.currentPlate_SIZEY=0
		GlobalUi.currentPlate_SIZEX=0
	if GlobalUi.givePlate==true:
		if setting==true:
			createPlate()
		var tile=local_to_map(get_local_mouse_position())
		for x in grid_size_x:
			for y in grid_size_y:
				erase_cell(2,Vector2(x,y))
		if dic.has(str(tile)):
			valid=true
			width=dimentions[0]
			height=dimentions[1]
			for a in width:
				for b in height:
					if dic.has(str(Vector2(tile.x+(countX+a),tile.y+(countY+b))))&&valid==true:
						count+=1
					else:
						valid=false
			for a in width:
				for b in height:
					if valid==true:
						if dic[str(Vector2(tile.x+(countX+a),tile.y+(countY+b)))]["Type"]=="empty":
							set_cell(2,Vector2(tile.x+(countX+a),tile.y+(countY+b)),3,Vector2i(0,0))
						else:
							set_cell(2,Vector2(tile.x+(countX+a),tile.y+(countY+b)),4,Vector2i(0,0))
					else:
						if dic.has(str(Vector2(tile.x+(countX+a),tile.y+(countY+b)))):
							set_cell(2,Vector2(tile.x+(countX+a),tile.y+(countY+b)),4,Vector2i(0,0))
		if Input.is_action_just_released("LeftClick"):
			valid=true
			var ok=0
			width=dimentions[0]
			height=dimentions[1]
			for n in width:
				for m in height:
					if dic.has(str(Vector2(tile.x+(countX+n),tile.y+(countY+m))))&&dic[str(Vector2(tile.x+(countX+n),tile.y+(countY+m)))]["Type"]=="empty":
						ok=0
					else:
						valid=false
			width=dimentions[0]
			height=dimentions[1]
			if valid==true&&width>0:
				for n in width:
					for m in height:
							set_cell(1,Vector2(tile.x+(countX+n),tile.y+(countY+m)),5,Vector2i(0,0))
							paint(tile.x+(countX+n),tile.y+(countY+m))
							for x in grid_size_x:
								for y in grid_size_y:
									erase_cell(2,Vector2(x,y))
				plate.position=map_to_local(tile)
				plate.set_tile(dic)
				GlobalUi.givePlate=false
				setting=true
			else:
				plate.queue_free()
				for x in grid_size_x:
					for y in grid_size_y:
						erase_cell(2,Vector2(x,y))
				GlobalUi.givePlate=false
				setting=true

func createPlate():
	plate=item.instantiate()
	add_child(plate)
	setting=false




func paint(w:int,h:int):
	dic[str(Vector2(w,h))]={
		"Type"="full"
	}





