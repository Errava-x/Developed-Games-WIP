extends CharacterBody2D

@onready var spaceShip = $"."
@export var spaceShipScene : PackedScene
var spaceShipInstance
@export var bulletScene : PackedScene
var bulletInstance
const gravity = 30
const jumpPower = -450



func _process(delta: float) -> void:
	
	velocity.y += gravity
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jumpPower
		shoot()
	move_and_slide()
	
	

func shoot() -> void:
	bulletInstance = bulletScene.instantiate()
	get_parent().add_child(bulletInstance)
	bulletInstance.global_position = Vector2(-350,spaceShip.position.y) 

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroidArea"):
		spaceShip.queue_free();
		Global.playerIsAlive = false
		

		
	
