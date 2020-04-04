extends Node2D
# variables for loops: x, y, z
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
var type=Global.CROSS
var ret
var secs
var move=[]

func createLineLR(from, to):
	line.add_point(from)
	line.add_point(to)
# End of createLineLR(from, to)

func createLineRL(to,from):
	line.add_point(from)
	line.add_point(to)
# End of createLineRL(to,from)

func start_timer():
	$CCControl/Think.start(Global.USER_TIME)
	resume_timer()
# End of start_timer()

func pause_timer():
	$CCControl/Think.paused=true
# End of pause_timer()

func resume_timer():
	$CCControl/Think.paused=false
# End of resume_timer()

func setup_tilemap():
	tilemap= get_node("CCControl/CCNode2D/TextureRect/TileMap")
	tilemap.scale.x=Global.WIDTH/(Global.current_size)
	tilemap.scale.y=Global.WIDTH/(Global.current_size)
	
func draw_grid():
	tilemap= get_node("CCControl/CCNode2D/TextureRect/TileMap")
	cellsizex=tilemap.cell_size.x*tilemap.scale.x;
	cellsizey=tilemap.cell_size.y*tilemap.scale.y;
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
# End of draw_grid()

func check_CheckBoxPlay():
	if Global.current_symbol!=Global.CROSS:
		$CCControl/CCNode2D/CheckBoxPlay.pressed=!$CCControl/CCNode2D/CheckBoxPlay.pressed
# End of check_CheckBoxPlay()

func refresh_score():
	$CCControl/CCNode2D/ScoreRichText.bbcode_text="Score:\t\tYou:"+String(Global.score)+"\t\tAI:"+String(Global.AIscore)
# End of refresh_score()

# Called when the node enters the scene tree for the first time.
# Here are all things needed to restore scene.
func _ready():
	setup_tilemap()
	draw_grid()
	setup_move()
	check_CheckBoxPlay()
	refresh_score()
	start_timer()
# End of _ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_on_TimerRichLabel_ready()
# End of _process(delta)

func _on_CredentialsButton_pressed():
	ret=get_tree().change_scene("res://cross-circle-credentials.tscn")
	print("Return:",ret)
# End of _on_CredentialsButton_pressed()

func _on_CheckBoxPlay_mouse_entered():
	$CCControl/CCNode2D/CheckBoxPlay.visible = !$CCControl/CCNode2D/CheckBoxPlay.visible
	$CCControl/CCNode2D/CheckBoxPlay.visible = !$CCControl/CCNode2D/CheckBoxPlay.visible
# End of _on_CheckBoxPlay_mouse_entered()

func _on_CheckBoxPlay_mouse_exited():
	$CCControl/CCNode2D/CheckBoxPlay.visible = !$CCControl/CCNode2D/CheckBoxPlay.visible
	$CCControl/CCNode2D/CheckBoxPlay.visible = !$CCControl/CCNode2D/CheckBoxPlay.visible
# End of _on_CheckBoxPlay_mouse_exited()

func _on_NewOKButton_pressed():
	$CCControl/NewPopup.visible = !$CCControl/NewPopup.visible
	new_game()
# End of _on_NewOKButton_pressed()

func _on_NewCancelButton_pressed():
	$CCControl/NewPopup.visible = !$CCControl/NewPopup.visible
	resume_timer()
# End of _on_NewCancelButton_pressed()

func _on_EndOKButton_pressed():
	get_tree().quit()
# End of _on_EndOKButton_pressed()

func _on_EndCancelButton_pressed():
	$CCControl/EndPopup.visible = !$CCControl/EndPopup.visible
	resume_timer()
# End of _on_EndCancelButton_pressed()

func _on_NewButton_pressed():
	pause_timer()
	if Global.moves_count>=5:
		$CCControl/Over5MovesPopup.visible= !$CCControl/Over5MovesPopup.visible
		$CCControl/Over5MovesPopup.show_modal(true)
	else:
		$CCControl/NewPopup.visible = !$CCControl/NewPopup.visible
		$CCControl/NewPopup.show_modal(true)
# End of _on_NewButton_pressed()

func _on_EndButton_pressed():
	pause_timer()
	$CCControl/EndPopup.visible = !$CCControl/EndPopup.visible
	$CCControl/EndPopup.show_modal(true)
# End of _on_EndButton_pressed()

func _on_WonOKButton_pressed():
	$CCControl/SomebodyWonPopup.visible = !$CCControl/SomebodyWonPopup.visible
	new_game()
# End of _on_WonOKButton_pressed()


func _on_SizeOption_item_selected(id):
	print("ID:",id, " Value:",Global.sizes[id])
	Global.size_index=$CCControl/CCNode2D/SizeOption.get_selected_id()
	Global.current_size=Global.sizes[Global.size_index]
	print("ID:",Global.size_index)
	
# End of _on_SizeOption_item_selected(id)

func _on_CCNode2D_ready():
	print("started CCNode2D")
	for x in range(1,Global.WIDTH+1):
		for y in range(1,Global.HEIGHT+1):
			$CCControl/CCNode2D/TextureRect/TileMap.set_cell(x,y,Global.matrix[x-1][y-1])
	$CCControl/CCNode2D/AILevelOption.select(Global.AILevel_index)
	$CCControl/CCNode2D/SizeOption.select(Global.size_index)
	
	#var module=$CCControl/CCNode2D/TextureRect/TileMap.cell_quadrant_size
	#var  okvir=Polygon2D.new()
	#okvir.color="#FF0000"

# End of _on_CCNode2D_ready()

func _on_AILevelOption_item_selected(id):
	Global.AILevel_index=$CCControl/CCNode2D/AILevelOption.get_selected_id()
	resume_timer()
# End of _on_AILevelOption_item_selected(id)

func check_move():
# type is CROSS or CIRCLE
	for x in range(0,Global.current_size):
		for y in range(0,Global.current_size):
			if Global.matrix[x][y]!=Global.EMPTY:
				type=Global.matrix[x][y]
				countR=1
				countB=1
				countLB=1
				countRB=1
# Now, check right, down, left-down and right-down
				for z in range(1,5):
					if x+z < Global.current_size and Global.matrix[x+z][y]==type:
						countR+=1
					if y+z < Global.current_size and Global.matrix[x][y+z]==type:
						countB+=1
					if x-z >= 0 and y+z < Global.current_size and Global.matrix[x-z][y+z]==type:
						countLB+=1
					if x+z < Global.current_size and y+z < Global.current_size and Global.matrix[x+z][y+z]==type:
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
#	if event.is_pressed() and (event.button_index== BUTTON_LEFT or event.button_index== BUTTON_RIGHT):
	if event.is_pressed() and (event.button_index==BUTTON_LEFT):
		var tilemap = $CCControl/CCNode2D/TextureRect/TileMap
		var tile_pos = tilemap.world_to_map(event.position)
		if (tile_pos.x>0) and (tile_pos.x<=Global.WIDTH) and (tile_pos.y>0) and (tile_pos.y<=Global.HEIGHT) and (Global.matrix[tile_pos.x-1][tile_pos.y-1]==Global.EMPTY): 
			start_timer()
			if event.button_index== BUTTON_LEFT:
				$CCControl/CCNode2D/TextureRect/TileMap.set_cell(tile_pos.x,tile_pos.y,Global.current_symbol)
				Global.matrix[tile_pos.x-1][tile_pos.y-1]=Global.current_symbol
				Global.moves_count+=1
#			else:
#				$CCControl/CCNode2D/TextureRect/TileMap.set_cell(tile_pos.x,tile_pos.y,0)
#				Global.matrix[tile_pos.x-1][tile_pos.y-1]=0
			var result=check_move()
			if result!=1:
# AI play
				choose_move(2)
				result=check_move()
			if result==1:
#				if ($CCControl/CCNode2D/CheckBoxPlay.pressed==false and type==Global.current_symbol) or ($CCControl/CCNode2D/CheckBoxPlay.pressed==true and type==Global.current_symbol):
				if type==Global.current_symbol:
					Global.score+=1
					$CCControl/SomebodyWonPopup/TextureRect/WonTextLabel.text="You won!"
				else:
					$CCControl/SomebodyWonPopup/TextureRect/WonTextLabel.text="You lost..."
					Global.AIscore+=1
				refresh_score()
				pause_timer()
				$CCControl/SomebodyWonPopup.visible=!$CCControl/SomebodyWonPopup.visible
				$CCControl/SomebodyWonPopup.show_modal(true)
				
		print("Event:", event.position, " Pos:",tile_pos)
# End of _on_TextureRect_gui_input(event)

func new_game():
	for x in range(1,Global.WIDTH+1):
		for y in range(1,Global.HEIGHT+1):
			$CCControl/CCNode2D/TextureRect/TileMap.set_cell(x,y,Global.EMPTY)
			Global.matrix[x-1][y-1]=Global.EMPTY
	$CCControl/CCNode2D/ScoreRichText.bbcode_text="Score:\t\tYou:"+String(Global.score)+"\t\tAI:"+String(Global.AIscore)
	Global.moves_count=0
	start_timer()
# End of new_game()

func _on_CheckBoxPlay_pressed():
	pause_timer()
	$CCControl/CheckBoxPlayPopup.visible=!$CCControl/CheckBoxPlayPopup.visible
	$CCControl/CheckBoxPlayPopup.show_modal(visible)
	print("CheckBoxPlay pressed")
# End of _on_CheckBoxPlay_pressed()

func _on_CheckBoxPlayOK_pressed():
	$CCControl/CheckBoxPlayPopup.visible=!$CCControl/CheckBoxPlayPopup.visible
	if Global.current_symbol==Global.CROSS:
		Global.current_symbol=Global.CIRCLE
	else:
		Global.current_symbol=Global.CROSS
#	var swap=Global.AIscore
#	Global.AIscore=Global.score
#	Global.score=swap
	new_game()
# End of _on_CheckBoxPlayOK_pressed()

func _on_CheckBoxPlayCancel_pressed():
	$CCControl/CheckBoxPlayPopup.visible=!$CCControl/CheckBoxPlayPopup.visible
	$CCControl/CCNode2D/CheckBoxPlay.pressed=!$CCControl/CCNode2D/CheckBoxPlay.pressed
	resume_timer()
# End of _on_CheckBoxPlayCancel_pressed()


#func _on_NewPopup_focus_exited():
#	$CCControl/NewPopup.visible=0
#	print("NewPopup exited")	
#	pass # Replace with function body.

#func _on_NewPopup_about_to_show():
#	$CCControl/NewPopup.show_modal(true)
#	pass # Replace with function body.

func _on_Think_timeout():
	pause_timer()
	$CCControl/TimerPopup.visible=!$CCControl/TimerPopup.visible
	$CCControl/TimerPopup.show_modal(true)
# End of _on_Think_timeout()

func _on_TimerOKButton_pressed():
	$CCControl/TimerPopup.visible=!$CCControl/TimerPopup.visible
	start_timer()
# End of _on_TimerOKButton_pressed()


func _on_TimerRichLabel_ready():
	if secs!=int($CCControl/Think.time_left):
		secs=int($CCControl/Think.time_left)
		$CCControl/TimerRichLabel.text="CD:"+String(secs)
		if (secs<18):
			match secs:
				1,6,16:
					$CCControl/decoration/x49.visible=!$CCControl/decoration/x49.visible
				11,4:
					$CCControl/decoration/o48.visible=!$CCControl/decoration/o48.visible
				13,8,3:
					$CCControl/decoration/x48.visible=!$CCControl/decoration/x48.visible
				15,9,2:
					$CCControl/decoration/o49.visible=!$CCControl/decoration/o49.visible
				17,10:
					$CCControl/decoration/x50.visible=!$CCControl/decoration/x50.visible
				14,7:
					$CCControl/decoration/o50.visible=!$CCControl/decoration/o50.visible
				12,5:
					$CCControl/decoration/x51.visible=!$CCControl/decoration/x51.visible
	
# End of _on_TimerRichLabel_ready()


func _on_AILevelOption_pressed():
	pause_timer()
# End of _on_AILevelOption_pressed()


func _on_AILevelOption_toggled(button_pressed):
	resume_timer()
# End of _on_AILevelOption_toggled(button_pressed)

func _on_SizeOption_pressed():
	pause_timer()
# End of _on_SizeOption_pressed()


func _on_Over5CancelButton_pressed():
	$CCControl/Over5MovesPopup.visible = !$CCControl/Over5MovesPopup.visible
	pass # Replace with function body.


func _on_Over5OKButton_pressed():
	$CCControl/Over5MovesPopup.visible = !$CCControl/Over5MovesPopup.visible
	Global.AIscore+=1
	new_game()
	pass # Replace with function body.


func _on_SizeOption_toggled(button_pressed):
	resume_timer()
# End of _on_SizeOption_toggled(button_pressed)

func setup_move():
	for x in range(Global.WIDTH):
			move.append([])
			for y in range(Global.HEIGHT):
				move[x].append([])
				move[x][y]=0

func choose_move(number):
	var dirL=0
	var dirR=0
	var dirU=0
	var dirD=0
	var dirLU=0
	var dirLD=0
	var dirRU=0
	var dirRD=0
	var sum=0
	
	if number>1:
		
		for x in range(0,Global.current_size):
			for y in range(0,Global.current_size):
				if Global.matrix[x][y]==Global.EMPTY:
# right
					z=1
					dirR=0
					while z<5:
						if (x+z)<Global.current_size:
							dirR=dirR*10+Global.matrix[x+z][y]+1;
						else:
							dirR=dirR*10;
						z+=1
					z=1
# down
					dirD=0
					while z<5:
						if (y+z)<Global.current_size:
							dirD=dirD*10+Global.matrix[x][y+z]+1;
						else:
							dirD=dirD*10;
						z+=1
# left
					z=1
					dirL=0
					while z<5:
						if (x-z)>=0:
							dirL=dirL*10+Global.matrix[x-z][y]+1;
						else:
							dirL=dirL*10;
						z+=1
					z=1
# up
					dirU=0
					while z<5:
						if (y-z)>=0:
							dirU=dirU*10+Global.matrix[x][y-z]+1;
						else:
							dirU=dirU*10;
						z+=1
					z=1
# right up
					dirRU=0
					while z<5:
						if ((x+z)<Global.current_size) and ((y-z)>=0):
							dirRU=dirRU*10+Global.matrix[x+z][y-z]+1;
						else:
							dirRU=dirRU*10;
						z+=1
					z=1
# right down
					dirRD=0
					while z<5:
						if ((x+z)<Global.current_size) and ((y+z)<Global.current_size):
							dirRD=dirRD*10+Global.matrix[x+z][y+z]+1;
						else:
							dirRD=dirRD*10;
						z+=1
					z=1
# left up
					dirLU=0
					while z<5:
						if ((x-z)>=0) and ((y-z)>=0):
							dirLU=dirLU*10+Global.matrix[x-z][y-z]+1;
						else:
							dirLU=dirLU*10;
						z+=1
					z=1
# left down
					dirLD=0
					while z<5:
						if (x-z)>=0 and ((y+z)<Global.current_size):
							dirLD=dirLD*10+Global.matrix[x-z][y+z]+1;
						else:
							dirLD=dirLD*10;
						z+=1
					dirL=find_weight(dirL)
					dirR=find_weight(dirR)
					dirU=find_weight(dirU)
					dirD=find_weight(dirD)
					dirLU=find_weight(dirLU)
					dirRD=find_weight(dirRD)
					dirRU=find_weight(dirRU)
					dirLD=find_weight(dirLD)
					if dirL>0 and dirR>0:
						sum=(dirL+dirR)*10
					else:
						sum=dirL+dirR
					if dirU>0 and dirD>0:
						sum+=(dirU+dirD)*10
					else:
						sum+=dirU+dirD
					if dirLU>0 and dirRD>0:
						sum+=(dirLU+dirRD)*10
					else:
						sum+=dirLU+dirRD
					if dirRU>0 and dirLD>0:
						sum+=(dirRU+dirLD)*10
					else:
						sum+=dirRU+dirLD
					move[x][y]=sum
				else:
					move[x][y]=0
		var maxx=-1
		var maxy=-1
		var maxval=0
		for x in range(0,Global.current_size):
			for y in range(0,Global.current_size):
				if move[x][y]>maxval:
					maxval=move[x][y]
					maxx=x
					maxy=y
		if (Global.current_symbol==Global.CIRCLE):
			Global.matrix[maxx][maxy]=Global.CROSS
			$CCControl/CCNode2D/TextureRect/TileMap.set_cell(maxx+1,maxy+1,Global.CROSS)
		else:
			Global.matrix[maxx][maxy]=Global.CIRCLE
			$CCControl/CCNode2D/TextureRect/TileMap.set_cell(maxx+1,maxy+1,Global.CIRCLE)
	else:
		return 1

func find_weight(pattern):
	var b
	match pattern:
		1000:
			b=50
		0100:
			b=40
		0010:
			b=40
		0001:
			b=30
		1100:
			b=80
		1010:
			b=55
		1001:
			b=50
		0110:
			b=60
		0101:
			b=25
		0011:
			b=20
		1110:
			b=50000
		1101:
			b=800
		1011:
			b=600
		0111:
			b=800
		1111:
			b=10000
		2000:
			b=10
		0200:
			b=20
		0020:
			b=20
		0002:
			b=20
		2200:
			b=50
		2020:
			b=50
		2002:
			b=50
		0220:
			b=100
		0202:
			b=300
		0022:
			b=200
		2220:
			b=400
		2202:
			b=500
		2022:
			b=500
		0222:
			b=300
		2222:
			b=1000
		1200:
			b=20
		1020:
			b=25
		1002:
			b=30
		0120:
			b=25
		0102:
			b=30
		0012:
			b=25
		2001:
			b=10
		0201:
			b=20
		0021:
			b=25
		1120:
			b=35
		1102:
			b=40
		1012:
			b=30
		1210:
			b=20
		1201:
			b=20
		1021:
			b=25
		2110:
			b=10
		0112:
			b=25
		2101:
			b=10
		0121:
			b=20
		2011:
			b=10
		0211:
			b=20
		1122:
			b=30
		1212:
			b=20
		1221:
			b=20
		2112:
			b=10
		2121:
			b=10
		2211:
			b=10
		1112:
			b=40
		1121:
			b=30
		1211:
			b=20
		2111:
			b=10
		1222:
			b=20
		2122:
			b=20
		2212:
			b=30
		2221:
			b=40
		_:
			b=0
	return(b)
