extends Node2D
# variables for loops
var x
var y
var z
# count to 5: right, bot, left-bot, right-bot
var countR
var countB
var countLB
var countRB
var five
var tilemap
var cellsizex
var cellsizey
onready var line=get_node("CCControl/MyLine")
const COLUMNS = 7
const ROWS = 6

func createLineLR(from, to):
	line.add_point(from)
	line.add_point(to)

func createLineRL(to,from):
	line.add_point(from)
	line.add_point(to)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print("started CCControl")
	print($CCControl/CCNode2D/TextureRect/TileMap.get_cell(0,0) )
	print($CCControl/CCNode2D/TextureRect/TileMap.get_cell(1,1) )
	print($CCControl/CCNode2D/TextureRect/TileMap.get_cell(2,2) )
	tilemap= get_node("CCControl/CCNode2D/TextureRect/TileMap")
	cellsizex=tilemap.cell_size.x;
	cellsizey=tilemap.cell_size.y;
	line.width=2
	line.default_color="333333"
	for y in range (1,Global.current_size+2):
		if y%2!=0:
			createLineRL(Vector2(cellsizex,y*cellsizey),Vector2((Global.current_size+1)*cellsizex,y*cellsizey))
		else:
			createLineLR(Vector2(cellsizex,y*cellsizey),Vector2((Global.current_size+1)*cellsizex,y*cellsizey))
	for x in range (Global.current_size+1,0,-1):
		if x%2!=0:
			createLineRL(Vector2(x*cellsizex,cellsizey),Vector2(x*cellsizex,(Global.current_size+1)*cellsizey))
		else:
			createLineLR(Vector2(x*cellsizex,cellsizey),Vector2(x*cellsizex,(Global.current_size+1)*cellsizey))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var ret
func _on_CredentialsButton_pressed():
	ret=get_tree().change_scene("res://cross-circle-credentials.tscn")
	print("Return:",ret)
	pass # Replace with function body.

func _on_CheckBoxPlay_mouse_entered():
	$CCControl/CCNode2D/CheckBoxPlay.visible = !$CCControl/CCNode2D/CheckBoxPlay.visible
	$CCControl/CCNode2D/CheckBoxPlay.visible = !$CCControl/CCNode2D/CheckBoxPlay.visible
	pass # Replace with function body.


func _on_CheckBoxPlay_mouse_exited():
	$CCControl/CCNode2D/CheckBoxPlay.visible = !$CCControl/CCNode2D/CheckBoxPlay.visible
	$CCControl/CCNode2D/CheckBoxPlay.visible = !$CCControl/CCNode2D/CheckBoxPlay.visible
	pass # Replace with function body.

func _on_NewOKButton_pressed():
	$CCControl/NewPopup.visible = !$CCControl/NewPopup.visible
	new_game()
	pass # Replace with function body.

func _on_NewCancelButton_pressed():
	$CCControl/NewPopup.visible = !$CCControl/NewPopup.visible
	pass # Replace with function body.

func _on_EndOKButton_pressed():
	get_tree().quit()
	pass # Replace with function body.

func _on_EndCancelButton_pressed():
	$CCControl/EndPopup.visible = !$CCControl/EndPopup.visible
	pass # Replace with function body.

func _on_NewButton_pressed():
	$CCControl/NewPopup.visible = !$CCControl/NewPopup.visible
	pass # Replace with function body.

func _on_EndButton_pressed():
	$CCControl/EndPopup.visible = !$CCControl/EndPopup.visible
	pass # Replace with function body.


func _on_WonOKButton_pressed():
	$CCControl/SomebodyWonPopup.visible = !$CCControl/SomebodyWonPopup.visible
	pass # Replace with function body.


func _on_SizeOption_item_selected(id):
	print("ID:",id, " Value:",Global.sizes[id])
	Global.size_index=$CCControl/CCNode2D/SizeOption.get_selected_id()
	Global.current_size=Global.sizes[Global.size_index]
	print("ID:",Global.size_index)
	
	pass # Replace with function body.ica[]

func _on_CCNode2D_ready():
	print("started CCNode2D")
	for x in range(1,Global.WIDTH+1):
		for y in range(1,Global.HEIGHT+1):
			$CCControl/CCNode2D/TextureRect/TileMap.set_cell(x,y,Global.matrica[x-1][y-1])
	$CCControl/CCNode2D/AILevelOption.select(Global.AILevel_index)
	$CCControl/CCNode2D/SizeOption.select(Global.size_index)
	
	var module=$CCControl/CCNode2D/TextureRect/TileMap.cell_quadrant_size
	var  okvir=Polygon2D.new()
	okvir.color="#FF0000"

	pass # Replace with function body

func _on_AILevelOption_item_selected(id):
	Global.AILevel_index=$CCControl/CCNode2D/AILevelOption.get_selected_id()
	pass # Replace with function body.

func check_move():
# type is CROSS or CIRCLE
	var type=Global.CROSS
	for x in range(0,Global.current_size):
		for y in range(0,Global.current_size):
			if Global.matrica[x][y]!=-1:
				type=Global.matrica[x][y]
				countR=1
				countB=1
				countLB=1
				countRB=1
# Now, check right, down, left-down and right-down
				for z in range(1,5):
					if x+z < Global.current_size and Global.matrica[x+z][y]==type:
						countR+=1
					if y+z < Global.current_size and Global.matrica[x][y+z]==type:
						countB+=1
					if x-z >= 0 and y+z < Global.current_size and Global.matrica[x-z][y+z]==type:
						countLB+=1
					if x+z < Global.current_size and y+z < Global.current_size and Global.matrica[x+z][y+z]==type:
						countRB+=1
				if countR==5:
					print ("CountR=5 ",x," ",y)
					return 1
				if countB==5:
					print ("CountB=5 ",x," ",y)
					return 1
				if countLB==5:
					print ("CountLB=5 ",x," ",y)
					return 1
				if countRB==5:
					print ("CountRB=5 ",x," ",y)
					return 1
	
	return 0
	pass # Replace with function body.
	
func _on_TextureRect_gui_input(event):
	if event.is_pressed() and (event.button_index== BUTTON_LEFT or event.button_index== BUTTON_RIGHT):
		var tilemap = $CCControl/CCNode2D/TextureRect/TileMap
		var tile_pos = tilemap.world_to_map(event.position)
		if tile_pos.x>0 and tile_pos.x<=Global.WIDTH and tile_pos.y>0 and tile_pos.y<=Global.HEIGHT: 
			if event.button_index== BUTTON_LEFT:
				$CCControl/CCNode2D/TextureRect/TileMap.set_cell(tile_pos.x,tile_pos.y,1)
				Global.matrica[tile_pos.x-1][tile_pos.y-1]=1
			else:
				$CCControl/CCNode2D/TextureRect/TileMap.set_cell(tile_pos.x,tile_pos.y,0)
				Global.matrica[tile_pos.x-1][tile_pos.y-1]=0
			var result=check_move()
			print("result",result)
			if result==1:
				$CCControl/SomebodyWonPopup/TextureRect/WonTextLabel.text="Izgubio si..."
				$CCControl/SomebodyWonPopup.visible=!$CCControl/SomebodyWonPopup.visible
		print("Event:", event.position, " Pos:",tile_pos)
		
	pass # Replace with function body.

func new_game():
	for x in range(1,Global.WIDTH+1):
		for y in range(1,Global.HEIGHT+1):
			$CCControl/CCNode2D/TextureRect/TileMap.set_cell(x,y,-1)
			Global.matrica[x-1][y-1]=-1
