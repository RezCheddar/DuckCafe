extends TileMap
@export var grid_size_x=4
@export var grid_size_y=4
@export var dic={} #dictionary
var volu
var valid=false
var cure=true
var color1=Color(1,0,0)
var color2=Color(1,0,1)
# Called when the node enters the scene tree for the first time.
var rand=RandomNumberGenerator.new()
func _ready():
	for x in grid_size_x:
		for y in grid_size_y:
			var skip:bool=false
			var preset:Vector2i=Vector2i(x,y)
			if get_cell_tile_data(0,preset) == null:
				skip=true
			else:
				skip=false
			var rng=rand.randi_range(0,1)
			if skip==false:
				var tileType=get_cell_source_id(0,preset)
				if tileType==1:
					dic[str(Vector2(x,y))]={
					"Type":"solid",
					"Volume":0,
					"State":"closed"
					}
					set_cell(0,Vector2(x,y),1,Vector2i(0,0),0)
				if tileType==2:
					dic[str(Vector2(x,y))]={
					"Type":"air",
					"Volume":0,
					"State":""
					}
					set_cell(0,Vector2(x,y),2,Vector2i(0,0),0)
			else:
				set_cell(0,Vector2(x,y),6,Vector2i(0,0),0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("LeftClick"):
		var tile=local_to_map(get_local_mouse_position())
		if dic.has(str(tile))&&dic[str(tile)]["Type"]=="air":
			add(tile)
	#if Input.is_action_pressed("Event"):
		#var tile=local_to_map(get_local_mouse_position())
		#if dic.has(str(tile))&&dic[str(tile)]["Type"]=="air":
			#set_cell(1,tile,1,Vector2i(0,0))
			#dic[str(Vector2(tile.x,tile.y))]={
				#"Type"="solid",
				#"Volume"=0,
				#"State"="closed"
			#}
	#if Input.is_action_just_released("Event"):
		#var tile=local_to_map(get_local_mouse_position())
		#if dic.has(str(tile))&&dic[str(tile)]["Type"]=="solid":
			#remove(tile)
func _process(delta):
	rules()
func close(tile:Vector2):
	var type=str(dic[str(Vector2(tile.x,tile.y))]["Type"])
	var v=dic[str(tile)]["Volume"]
	var state=str(dic[str(Vector2(tile.x,tile.y))]["State"])
	if v<4:
		dic[str(Vector2(tile.x,tile.y))]={
			"Type"=type,
			"Volume"=v,
			"State"="closed"
		}
func nutral(tile:Vector2):
	var type=str(dic[str(Vector2(tile.x,tile.y))]["Type"])
	var v=dic[str(tile)]["Volume"]
	if v<4:
		dic[str(Vector2(tile.x,tile.y))]={
			"Type"=type,
			"Volume"=v,
			"State"=""
		}
func open(tile:Vector2):
	var type=str(dic[str(Vector2(tile.x,tile.y))]["Type"])
	var v=dic[str(tile)]["Volume"]
	var state=str(dic[str(Vector2(tile.x,tile.y))]["State"])
	if v<4:
		dic[str(Vector2(tile.x,tile.y))]={
			"Type"=type,
			"Volume"=v,
			"State"="open"
		}
func add(tile:Vector2):
	if Input.is_action_pressed("ui_down"):
		set_cell(1,tile,6,Vector2i(0,0))
		var v=dic[str(tile)]["Volume"]
		v+=1
		var state=str(dic[str(Vector2(tile.x,tile.y))]["State"])
		if v<4:
			dic[str(Vector2(tile.x,tile.y))]={
				"Type"="water",
				"Volume"=v,
				"State"=state
			}
	else:
		set_cell(1,tile,5,Vector2i(0,0))
		var v=dic[str(tile)]["Volume"]
		v+=1
		var state=str(dic[str(Vector2(tile.x,tile.y))]["State"])
		if v<4:
			dic[str(Vector2(tile.x,tile.y))]={
				"Type"="water",
				"Volume"=v,
				"State"=state
			}
func remove(tile:Vector2):
	erase_cell(1,tile)
	dic[str(Vector2(tile.x,tile.y))]={
		"Type"="air",
		"Volume"=0,
		"State"=""
	}
func rules():
	for x in grid_size_x:
		for y in grid_size_y:
			var tile=Vector2(grid_size_x-x-1,grid_size_y-y-1) #reversed
			if dic.has(str(tile)):
				valid=true
				if dic[str(tile)]["Type"]=="air":
					dic[str(tile)]={
					"Type"="air",
					"Volume"=0,
					"State"=""
					}

				##Behaviours
				if dic[str(tile)]["Type"]=="water":    ##water type viscocity
					#if dic[str(Vector2(tile.x,tile.y))]["State"]=="open":
						#set_cell(0,Vector2(x,y),5,Vector2i(0,0),0)
					#if dic[str(Vector2(tile.x,tile.y))]["State"]=="":
						#set_cell(1,tile,3,Vector2i(0,0))
					#if dic[str(Vector2(tile.x,tile.y))]["State"]=="closed":
						#set_cell(1,tile,4,Vector2i(0,0))

					##RULE FOR FALLING
					if dic.has(str(Vector2(tile.x,tile.y+1))):
						if dic[str(Vector2(tile.x,tile.y+1))]["State"]!="closed":
							var new:Vector2=Vector2(tile.x,tile.y+1)
							add(new)
							remove(tile)

					##RULE FOR SPREADING
					if dic[str(tile)]["Volume"]>2:
						if  dic.has(str(Vector2(tile.x+1,tile.y))) and dic.has(str(Vector2(tile.x-1,tile.y))):
							if dic[str(Vector2(tile.x+1,tile.y))]["Type"]!="solid"and dic[str(Vector2(tile.x-1,tile.y))]["Type"]!="solid":
								if dic[str(Vector2(tile.x+1,tile.y))]["Volume"]<3 or dic[str(Vector2(tile.x-1,tile.y))]["Volume"]<3:
									remove(tile)
									add(tile)
									add(Vector2(tile.x+1,tile.y))
									add(Vector2(tile.x-1,tile.y))
							else:
									if dic[str(Vector2(tile.x+1,tile.y))]["Type"]!="solid":
										remove(tile)
										add(tile)
										add(Vector2(tile.x+1,tile.y))
									if dic[str(Vector2(tile.x-1,tile.y))]["Type"]!="solid":
										remove(tile)
										add(tile)
										add(Vector2(tile.x-1,tile.y))
					##RULE FOR DIRECTIONAL SPREADING
						else:
							if  dic.has(str(Vector2(tile.x+1,tile.y))):
								if dic[str(Vector2(tile.x+1,tile.y))]["Type"]!="solid":
									remove(tile)
									add(tile)
									add(Vector2(tile.x+1,tile.y))
							if dic.has(str(Vector2(tile.x-1,tile.y))):
								if dic[str(Vector2(tile.x-1,tile.y))]["Type"]!="solid":
									remove(tile)
									add(tile)
									add(Vector2(tile.x-1,tile.y))
					##RULE FOR THE TRUE INFECTION

					if dic.has(str(Vector2(tile.x-1,tile.y))):
						if dic[str(Vector2(tile.x-1,tile.y))]["Type"]!="air":
							if dic.has(str(Vector2(tile.x+1,tile.y))):
								if dic[str(Vector2(tile.x+1,tile.y))]["State"]=="closed" :
									if dic[str(Vector2(tile.x-1,tile.y))]["State"]!="open":
										close(tile)
									else:
										open(tile)
							else:
								close(tile)
						else:
							open(tile)
					if dic.has(str(Vector2(tile.x+1,tile.y))):
						if dic[str(Vector2(tile.x+1,tile.y))]["Type"]!="air":
							if dic.has(str(Vector2(tile.x-1,tile.y))):
								if dic[str(Vector2(tile.x-1,tile.y))]["State"]=="closed" :
									if dic[str(Vector2(tile.x+1,tile.y))]["State"]!="open":
										close(tile)
									else:
										open(tile)
							else:
								close(tile)
						else:
							open(tile)

