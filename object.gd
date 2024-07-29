extends CharacterBody2D
class_name object
#the gravity value
var gravity = 35
var rand=RandomNumberGenerator.new()
#the motion vector
#we'll use it to move our stone with move_and_slide
var motion = Vector2.ZERO

#so the stone won't accelerate forever
var max_speed = 600

var max_speed_in_water = 200
func _ready():
	var angle=rand.randf_range(0,360)
	$Sprite2D.rotation=angle
	$CPUParticles2D.emitting=false
	$CPUParticles2D.speed_scale=1
	$CPUParticles2D.explosiveness=1
	$CPUParticles2D.lifetime=0.5
	$CPUParticles2D.amount=5

func _physics_process(delta):
	#at each frame add gravity to our motion vector
	#clamp the motion value to the speed
	#move the stone with move_and_slide
	velocity.y += gravity
	velocity.y = clamp(velocity.y, -max_speed, max_speed)
	move_and_slide()
	if velocity.y<1:
		await get_tree().create_timer(0.4).timeout
		$CPUParticles2D.visible=false
		$CPUParticles2D.emitting=false
		$CPUParticles2D.speed_scale=1
		$CPUParticles2D.explosiveness=1
		$CPUParticles2D.lifetime=0.5
		$CPUParticles2D.amount=5


#initializes the stone at a set position
func initialize(pos):
	global_position = pos

func in_water():
	$CPUParticles2D.emitting=true
	max_speed = max_speed_in_water/2
	await get_tree().create_timer(0.4).timeout
	$CPUParticles2D.speed_scale=0.2
	$CPUParticles2D.lifetime=0.2
	$CPUParticles2D.amount=2
	$CPUParticles2D.explosiveness=0
	$CPUParticles2D.emitting=true
	$CPUParticles2D.one_shot=false




func _on_area_2d_area_entered(area):
	in_water()


func _on_area_2d_area_exited(area):
	if area is water:
		queue_free()
		print("f")
