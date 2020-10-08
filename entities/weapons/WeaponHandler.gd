extends Spatial
class_name WeaponHandler

"""
Add each weapon as child scene to the weapon Handler. And hide them.
When activating a weapon, these nodes are then referred to.
"""


var isFiring: bool = false
var _activeWeapon: WeaponBase
var weapons: Dictionary  # Key: Weapon Name, Value: bool: unlocked or not

func _ready():
	for child in get_children():
		child = child as WeaponBase
		weapons[child.weaponName] = false


func _process(delta):
	if is_instance_valid(_activeWeapon):
		_activeWeapon.isFiring = isFiring


func pick_up_weapon(weaponName: String) -> void:
	assert(weaponName in weapons.keys())
	if weapons[weaponName] == false:
		weapons[weaponName] = true  # i.e., unlock the weapon
		if not is_instance_valid(_activeWeapon):
			var weaponIndex: int = _get_index_of_weaponName(weaponName)
			switch_to_weapon_of_index(weaponIndex)
	else:
		var weapon: WeaponBase = _get_weapon_of_name(weaponName)
		weapon.add_ammunition(weapon.baseAmmunition)
		

func switch_to_weapon_of_index(weaponIndex: int) -> void:
	if weaponIndex < get_child_count():
		var weapon: WeaponBase = _get_weapon_of_index(weaponIndex)
		if weapons[weapon.weaponName] == true:  # only activate when unlocked
			if is_instance_valid(_activeWeapon):
				_activeWeapon.hide()
			_activeWeapon = weapon
			_activeWeapon.show()
		else:
			print('Weapon is not unlocked')


func _get_weapon_of_name(wname: String) -> WeaponBase:
	var weaponNode: WeaponBase
	for child in get_children():
		child = child as WeaponBase
		if child.weaponName == wname:
			weaponNode = child
			break
	assert(is_instance_valid(weaponNode))
	return weaponNode


func _get_index_of_weaponName(wname: String) -> int:
	var index: int = 0
	for child in get_children():
		child = child as WeaponBase
		if child.weaponName == wname:
			break
		else:
			index += 1
			
	return index


func _get_weapon_of_index(weaponIndex: int) -> WeaponBase:
	var weapon: WeaponBase = get_children()[weaponIndex]
	assert(is_instance_valid(weapon))
	return weapon
