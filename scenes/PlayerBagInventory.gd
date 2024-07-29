extends Node2D
@onready var bag=preload("res://resources/Inventorys/PlayerInventory.tres")
@onready var slot=preload("res://scenes/inventoryslots.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for x in bag.inventory.size():
		var slot=bag.inventory[x]
		if slot.Item !=null:
			$ScrollContainer/GridContainer.get_child(x).update(slot.Item.image,slot.Amount)
