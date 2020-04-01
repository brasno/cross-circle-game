extends Node

# maximun width and height
const WIDTH = 21
const HEIGHT = 21 
const CROSS = 0
const CIRCLE = 1
const USER_TIME=20
var matrica=[]
var sizes=[21,19,17,15,13,11,9]
var size_index=0
var current_size=21
var AILevel_index=0
var current_symbol=CROSS
var x
var y
var score = 0
var AIscore = 0
onready var tilemap 


# Called when the node enters the scene tree for the first time.
func _ready():
	clear_data()
#	matrica[1][1]=1
#	matrica[2][3]=0
#	print("started Global")
# End of _ready()

func clear_data():
	for x in range(WIDTH):
		matrica.append([])
		for y in range(HEIGHT):
			matrica[x].append([])
			matrica[x][y]=-1
# End of lear_data()
