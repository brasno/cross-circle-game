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

var ret
func _on_OKButton_pressed():
	ret=get_tree().change_scene("res://cross-circle-main.tscn")
	pass # Replace with function body.


func _draw():
	draw_line(Vector2(0,0),Vector2(600,200),"#123456",5.0)
	draw_circle(Vector2(60+2*100, 60+2*100), 40, "#FFFFFF")
	pass # Replace with function body.
