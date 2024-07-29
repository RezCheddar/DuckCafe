extends TileMap
var inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory=false
	$CanvasLayer/Node2D.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("Inventory"):
		if inventory==true:
			inventory=false
			$CanvasLayer/Node2D.visible=false
		else:
			inventory=true
			$CanvasLayer/Node2D.visible=true

