extends KinematicBody2D

var direccion = Vector2.RIGHT
var gravedad = Vector2(0,9)
var velocidad = 100



func _physics_process(delta):
	
	direccion = move_and_slide_with_snap(direccion.normalized() , Vector2.DOWN, Vector2.UP)
	
	print(direccion)

