extends Panel
var image:Texture2D
var number:int

# Called when the node enters the scene tree for the first time.
func _ready():
	number=0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if number==0:
		$TextureRect/Label.visible=false

func update(image:Texture2D,amount:int):
	$TextureRect.texture=image
	number=amount
	$TextureRect/Label.visible=true
	$TextureRect/Label.text=str(amount)
