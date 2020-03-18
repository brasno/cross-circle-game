extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CredentialsButton_pressed():
	get_tree().change_scene("res://cross-circle-credentials.tscn")
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
