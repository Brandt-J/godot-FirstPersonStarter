extends Spatial

export var assignedWeapon: PackedScene
var displayWeapon: Spatial


func _ready():
	assert(assignedWeapon != null)
	displayWeapon = assignedWeapon.instance()
	add_child(displayWeapon)
	displayWeapon.set_owner(self)
	
func _process(delta):
	displayWeapon.rotate_y(delta)

func _on_TriggerArea_body_entered(body):
	if body is Player:
		body.pickup_weapon(assignedWeapon)
