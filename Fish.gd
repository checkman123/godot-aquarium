extends CharacterBody2D

var min_speed = 100
var acc = randf() * 360
var speed = 0
var vel = Vector2()
var timer = 0
var max_timer = .1
var rot = 0
var world_size
var bounce = 1
var bounce_damping = 0.5

var coin_timer = 0
var max_coin_timer = 5

func _ready():
	world_size = get_viewport_rect().size
	vel = Vector2(1, 0).rotated(randf()*360)

func _physics_process(delta):
	randomize_speed_and_direction(delta)
	position += speed * vel * delta
	
	spawn_coin(delta)
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
func spawn_coin(delta):
	coin_timer += delta * randf()
	if coin_timer > max_coin_timer:
		coin_timer = 0
		var character_scene = preload("res://Objects/Coins/GoldCoin.tscn")
		var character_instance = character_scene.instantiate()
		character_instance.position = position
		add_sibling(character_instance)

func randomize_speed_and_direction(delta):
	timer += delta * randf()
	if timer > max_timer:
		timer = 0
		vel = vel.rotated(-.5 + randf())
		
	acc += delta * randf() * .1
	if acc >= 360: acc = 0
	if speed < 2 * min_speed: speed += delta
	
	
	var pos = position
	if pos.x < 0:
		pos.x = 2
		vel = Vector2(-vel.x, vel.y)
		speed *= bounce_damping
		acc = 0
	elif pos.x > world_size.x:
		vel = Vector2(-vel.x, vel.y)
		speed *= bounce_damping
		acc = 0
		
	if pos.y < 1:
		pos.y = 2
		vel = Vector2(vel.x, -vel.y)
		speed *= bounce_damping
		acc = 0
	elif pos.y > world_size.y:
		vel = Vector2(vel.x, -vel.y)
		speed *= bounce_damping
		acc = 0
		
	var facing_direction = vel.normalized()
	if facing_direction.x > 0:
		get_node("AnimatedSprite2D").flip_h = false
	elif facing_direction.x < 0:
		get_node("AnimatedSprite2D").flip_h = true
		
		
	speed = min_speed + (min_speed * 0.73 * sin(acc * 4.6)) + (min_speed/4 * sin(acc * 0.16)) + (min_speed/2 * sin(acc * 3.14))
	
