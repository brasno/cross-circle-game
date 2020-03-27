extends Node

# maximun width and height
const WIDTH = 21
const HEIGHT = 21 
const CROSS = 0
const CIRCLE = 1
var matrica=[]
var sizes=[21,19,17,15,13,11,9]
var size_index=0
var current_size=21
var AILevel_index=0
var x
var y
onready var tilemap 

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_data()
	matrica[1][1]=1
	matrica[2][3]=0
	print("started Global")
	pass # Replace with function body.

func clear_data():
	for x in range(WIDTH):
		matrica.append([])
		for y in range(HEIGHT):
			matrica[x].append([])
			matrica[x][y]=-1
	pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
