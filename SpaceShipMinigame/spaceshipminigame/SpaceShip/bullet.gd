extends CharacterBody2D

@onready var bulletMother = $"."
var bulletSpeed = 20


func _process(delta: float) -> void:
		position.x += bulletSpeed
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroidArea"):
		bulletMother.queue_free()
	if area.is_in_group("breakableAsteroidArea"):
		Global.brokenAsteroidsCount += 1
		Global.asteroidsOnScreen -= 1
		print("Broken Asteroids: "+str(Global.brokenAsteroidsCount))
		
