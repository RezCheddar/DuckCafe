extends Node2D
@export var k=0.02
@export var d=0.1
@export var spread=0.1
var springs=[]
var passes=8
var start=0
@export var distance_between_springs=32
@export var spring_number=10
var water_lenght=distance_between_springs*spring_number
@onready var water_spring=preload("res://water_area.tscn")
@export var depth=199
var target_height=global_position.y
var bottom=target_height+depth

@onready var water_polygon=$Water_Polygon
@onready var water_border=$Water_Border
@export var border_thickness=1.1
# Called when the node enters the scene tree for the first time.
func _ready():
	start=0
	water_border.width=border_thickness
	spread=spread/100
	for i in range(spring_number):
		var x_position=distance_between_springs*i
		var w=water_spring.instantiate()
		
		add_child(w)
		springs.append(w)
		w.initialize(x_position,i)

		w.connect("splash",splash)

func p():
	print("sxsx")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for i in springs:
		i.water_update(k,d)
	var left_deltas=[]
	var right_deltas=[]
	
	
	for i in range (springs.size()):
		left_deltas.append(0)
		right_deltas.append(0)
		pass
	
	for j in range(passes):
		for i in range (springs.size()):
			if i>0:
				left_deltas[i]=spread*(springs[i].height-springs[i-1].height)
				springs[i-1].velocity+=left_deltas[i]
			if i < springs.size()-1:
				right_deltas[i]=spread*(springs[i].height-springs[i+1].height)
				springs[i+1].velocity+=left_deltas[i]
	new_border()
	draw_water_body()
func splash(index,speed):
	if index >=0 and index<springs.size():
		springs[index].velocity+=speed 
	pass
func draw_water_body():
	var curve=water_border.curve
	var points=Array(curve.get_baked_points())
	var water_polygon_points=points
	var first_index=0
	var last_index=water_polygon_points.size()-1

	water_polygon_points.append(Vector2(water_polygon_points[last_index].x,bottom))
	water_polygon_points.append(Vector2(water_polygon_points[first_index].x,bottom))
	
	water_polygon_points=PackedVector2Array(water_polygon_points)
	water_polygon.set_polygon(water_polygon_points)
	pass

func new_border():
	var curve=Curve2D.new().duplicate()
	var surface_points=[]
	for i in range(springs.size()):
		surface_points.append(springs[i].position)
	
	for i in range(surface_points.size()):
		curve.add_point(surface_points[i])
	
	water_border.curve=curve
	water_border.smooth(true)
	water_border.queue_redraw()

func increasedepth():
	global_position.y-=5
	target_height=global_position.y
	$Button.global_position.y+=5

	draw_water_body()






func _on_button_button_down():
	increasedepth()
