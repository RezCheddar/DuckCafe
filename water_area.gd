extends Node2D
class_name water
var velocity=0
var force=0
var height=0
var target_height=0
var index=2
var speed=4
var motion_factor=0.02
signal splash
signal water
@onready var collision=$Area2D/CollisionShape2D
func water_update(spring_constant,dampening):
	height=position.y
	var x = height-target_height
	var loss=-dampening*velocity
	force=-spring_constant*x+loss
	velocity+=force
	position.y+=velocity
	pass

# Called when the node enters the scene tree for the first time.

func initialize(x_position,id):
	height=position.y
	target_height=position.y
	velocity=0
	position.x=x_position
	index=id
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_2d_body_entered(body):

	speed = body.velocity.y * motion_factor
	if body is object:
		emit_signal("splash",index,speed)
	#emit the signal "splash" to call the splash function, at our water body script
	pass # Replace with function body.
