extends Node
# access to varibles here is Global.<variable_name>
# maximun width and height
const WIDTH = 21
const HEIGHT = 21
# constants for board elements
const EMPTY = -1
const CROSS = 0
const CIRCLE = 1
# timer for "Do something!" message
const USER_TIME=20
# general matrix of moves
var matrix=[]
# sizes of board for dropdown
var sizes=[21,19,17,15,13,11,9]
var size_index=0
var current_size=21
# AI level
var AILevel_index=0
# current symbol for players
var current_symbol=CROSS
var x
var y
# current score
var score = 0
var AIscore = 0
# moves count
var moves_count=0

#sounds: positions, state  and volumes
var play_position_main = 0 
var main_playing = true
var play_position_credentials = 0 
var credentials_playing = true
var play_position_X = 0
var X_playing = false
var play_position_O = 0
var O_playing = false
var Music_volume = 0
var FX_volume = 0
var Music_mute = false
var FX_mute = false

# Buttons pressed
var Sound_pressed = false
var FX_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_data()
#	matrix[1][1]=1
#	matrix[2][3]=0
#	print("started Global")
# End of _ready()

func clear_data():
	for x in range(WIDTH):
		matrix.append([])
		for y in range(HEIGHT):
			matrix[x].append([])
			matrix[x][y]=EMPTY
# End of clear_data()
