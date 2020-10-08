extends Spatial

export var assignedWeapon: PackedScene
var displayWeapon: WeaponBase
var _assignedWeaponName: String


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
