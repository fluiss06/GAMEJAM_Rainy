#extends KinematicBody2D

#const WALK_FORCE = 600
#const WALK_MAX_SPEED = 200
#const STOP_FORCE = 1300
#const JUMP_SPEED = 200
#
#var velocity = Vector2()
#
#var gravity = 200
#
#func _physics_process(delta):
#	# Horizontal movement code. First, get the player's input.
#	var walk = WALK_FORCE * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
#	# Slow down the player if they're not trying to move.
#	if abs(walk) < WALK_FORCE * 0.2:
#		# The velocity, slowed down a bit, and then reassigned.
#		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
#	else:
#		velocity.x += walk * delta
#	# Clamp to the maximum horizontal movement speed.
#	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
#
#	# Vertical movement code. Apply gravity.
#	velocity.y += gravity * delta
#
#	# Move based on the velocity and snap to the ground.
#	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
#	print(velocity)
#
#	# Check for jumping. is_on_floor() must be called after movement code.
#	if is_on_floor() and Input.is_action_just_pressed("salto_a"):
#		velocity.y = -JUMP_SPEED





extends KinematicBody2D

var vel = 200
export var fuerza_salto = 200
export var gravedad = 7
var direccion = Vector2.ZERO

var direccion_salto = Vector2.ZERO
var angulo_salto = deg2rad(90)
var puntos = []
var t = 0.2
var stop = false
var dir_angulo = -0.1

var c = 1

var point = preload("res://player/punto.tscn")

func _ready():
	
	for i in 20:
		puntos.append(point.instance())
#		puntos[i].visible = false
		add_child(puntos[i])
		

		
func _physics_process(delta):
	
	if !stop:
		direccion.x = vel
	
	if !is_on_floor():
		direccion.y += gravedad
		
	if Input.is_action_just_pressed("salto_a") and is_on_floor():
		direccion.y = 0
		direccion.y = -fuerza_salto
		
	direccion = move_and_slide_with_snap(direccion ,Vector2.DOWN,Vector2.UP)
	
#	direccion_salto.x = Input.get_action_strength("ui_right")
#	direccion_salto.y = Input.get_action_strength("ui_up")

#	angulo_salto = direccion_salto.angle()
			
	if Input.is_action_pressed("salto_b"):
		direccion.x = 0
		stop = true
		mostrar_puntos()
	if Input.is_action_just_released("salto_b"):
		direccion.x = 0
		stop = false
		t = 0
		ocultar_puntos()
		
		direccion = direccion_salto.normalized() * fuerza_salto * 3
		print("DIRRR ", direccion)
		angulo_salto = deg2rad(90)
		
	print(direccion)


func mostrar_puntos():
	for i in puntos:
		i.visible = true
		
		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left"):
#			angulo_salto = lerp_angle(angulo_salto, angulo_salto + 0.5, 0.01)
			dir_angulo = 0.1
		if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_down"):
#			angulo_salto = lerp_angle(angulo_salto, angulo_salto - 0.5, 0.01)
			dir_angulo = -0.1
		
		
		angulo_salto = lerp_angle(angulo_salto, angulo_salto + dir_angulo, 0.005)
		
		
		i.position.x = 45 * cos(-angulo_salto) * t
		i.position.y = 45 * sin(-angulo_salto) * t - (-gravedad/2) * t * t
		t = t + 0.5
		
		
#		var n_p_x = 45 * cos(-direccion_salto.angle()) * t
#		var n_p_y = 45 * sin(-direccion_salto.angle()) * t - (-gravedad/2) * t * t
#		i.position = lerp(i.position, Vector2(n_p_x, n_p_y), 0.01)
#		t = t + 0.5

	t = 0


func ocultar_puntos():
	for i in puntos:
		i.visible = false


#func _input(event):
#
#	if event is InputEventKey:
#		if Input.is_action_pressed("ui_right"):
#			direccion_salto.x = 1
#		if Input.is_action_pressed("ui_left"):
#			direccion_salto.y = 1
#
#		print(direccion_salto)
	
	
	
	
	
#
#	if event is InputEventJoypadMotion:
#		if event.axis == 0:
#			direccion_salto.x = event.axis_value
#		if event.axis == 1:
#			direccion_salto.y = event.axis_value
#
#		print(direccion_salto.normalized())
