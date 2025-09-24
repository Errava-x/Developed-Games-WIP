extends CharacterBody2D

@export var breakableAsteroidScene : PackedScene
@export var unbreakableAsteroidScene : PackedScene
@onready var motherColumn = $"."
var breakableAsteroidInstance
var unbreakableAsteroidInstance
@export var spaceShipScene : PackedScene
var spaceShipInstance
var deathTimer = 0
@onready var respawnPoint = $marker8.position
@onready var asteroidsPositionsList = [$marker1.position,$marker2.position,$marker3.position,$marker4.position,$marker5.position,$marker6.position,$marker7.position]

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	respawnPlayer(delta)
	print("Asteroides: "+str(Global.asteroidsOnScreen))
	if Global.asteroidsOnScreen == 0:
		createColumn()
	
func createColumn() -> void:
	Global.columnsOnScreen += 1
	var asteroidsColumns = []
	for marker in asteroidsPositionsList:
		var rng = randi_range(0,1)
		var pos = marker
		spawnAsteroid(rng, pos)
		checkIfPossible()
	
	
func spawnAsteroid(rng : int, pos : Vector2)-> void:
	match rng:
		0:
			breakableAsteroidInstance = breakableAsteroidScene.instantiate()
			add_child(breakableAsteroidInstance)
			breakableAsteroidInstance.position = pos
			Global.asteroidsOnScreen +=1
		1:
			unbreakableAsteroidInstance = unbreakableAsteroidScene.instantiate()
			add_child(unbreakableAsteroidInstance)
			unbreakableAsteroidInstance.position = pos
			Global.asteroidsOnScreen +=1
	
func checkIfPossible() -> void:
	
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("columna algo")
	if area.is_in_group("leftBoundary"):
		print("columna contra left")
		motherColumn.queue_free()
		Global.asteroidsOnScreen -= 1
	if area.is_in_group("limitArea"):
		velocity.y = 0
		
func respawnPlayer(delta):
	if Global.playerIsAlive == true:
		deathTimer = 0
		print("is alive! " + str(deathTimer))
	else:
		print("is dead " + str(deathTimer))
		deathTimer += delta
		if deathTimer > 1.5:
			spaceShipInstance = spaceShipScene.instantiate()
			add_child(spaceShipInstance)
			spaceShipInstance.position = respawnPoint
			Global.playerIsAlive = true
