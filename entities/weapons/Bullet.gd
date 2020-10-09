extends RigidBody

"""
Simple bullet scene that deletes itself after a few seconds...
"""

func _on_Timer_timeout():
	queue_free()
