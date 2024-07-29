extends Node2D
var cookwarePanel:int
@onready var cookwareIndex=preload("res://resources/Inventorys/PlayerCookwareIndex.tres")
@onready var instPanel=preload("res://resources/Kitchenware/serving_ui_panels.tscn")
@onready var item=preload("res://resources/Kitchenware/kitchen_ware.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	cookwarePanel=0
	for i in cookwareIndex.index.size():
		var inst=instPanel.instantiate()
		$ScrollContainer/Panel/Cutlery.add_child(inst)
		inst.set_index(cookwarePanel)
		cookwarePanel+=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
