extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#const WIDTH = 21
#const HEIGHT = 21 
#var matrica=[]
#var sizes=[21,19,17,15,13,11,9]
var x
var y

# Called when the node enters the scene tree for the first time.
func _ready():
	print("started CCControl")
	print($CCControl/CCNode2D/TextureRect/TileMap.get_cell(0,0) )
	print($CCControl/CCNode2D/TextureRect/TileMap.get_cell(1,1) )
	print($CCControl/CCNode2D/TextureRect/TileMap.get_cell(2,2) )
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
	for x in range(1,Global.WIDTH+1):
		for y in range(1,Global.HEIGHT+1):
			$CCControl/CCNode2D/TextureRect/TileMap.set_cell(x,y,-1)
			Global.matrica[x-1][y-1]=-1
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


func _on_SizeOption_item_selected(id):
	print("ID:",id, " Value:",Global.sizes[id])
	Global.size_index=$CCControl/CCNode2D/SizeOption.get_selected_id()
	print("ID:",Global.size_index)
	
	pass # Replace with function body.ica[]

func _on_CCNode2D_ready():
	print("started CCNode2D")
	for x in range(1,Global.WIDTH+1):
		for y in range(1,Global.HEIGHT+1):
			$CCControl/CCNode2D/TextureRect/TileMap.set_cell(x,y,Global.matrica[x-1][y-1])
	$CCControl/CCNode2D/AILevelOption.select(Global.AILevel_index)
	$CCControl/CCNode2D/SizeOption.select(Global.size_index)
	pass # Replace with function body.

func _on_AILevelOption_item_selected(id):
	Global.AILevel_index=$CCControl/CCNode2D/AILevelOption.get_selected_id()
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
		print("Event:", event.position, " Pos:",tile_pos)
		
	pass # Replace with function body.
