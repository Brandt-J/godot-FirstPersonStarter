extends Spatial

export var assignedWeapon: PackedScene
var displayWeapon: WeaponBase
var _assignedWeaponName: String


"""
This class is used to provide a Weapon Pickup. In the inspector, assign a 
WeaponScene to the 'assigned Weapon'.
To make the pickup happen, it is important that the player is of the class
'Player', see the _on_TriggerArea_body_entered method. Any other way of
making sure that only the player is targeted could be implemented there..
"""

func _ready():
	assert(assignedWeapon != null)
	displayWeapon = assignedWeapon.instance()
	_assignedWeaponName = displayWeapon.weaponName
	add_child(displayWeapon)
	displayWeapon.set_owner(self)


func _process(delta):
	displayWeapon.rotate_y(delta)


func _on_TriggerArea_body_entered(body):
	if body is Player:
		body.pickup_weapon(_assignedWeaponName)
