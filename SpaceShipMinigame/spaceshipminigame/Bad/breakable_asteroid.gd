extends CharacterBody2D

@onready var asteroidMother = $"."


func _process(delta: float) -> void:
	position.x += Global.asteroidSpeed

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bulletArea"):
		print("bullet into breakableAsteroid ")
		asteroidMother.queue_free()
	if area.is_in_group("leftBoundary"):
		print("breakableAsteroid into left")
		asteroidMother.queue_free()
		Global.asteroidsOnScreen -= 1
