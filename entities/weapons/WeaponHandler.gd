extends Spatial
class_name WeaponHandler

var isFiring: bool = false
var _activeWeapon: WeaponBase
var weapons: Dictionary  # Key: Weapon name, Value: Weapon Node
export var keys2Weapons: Dictionary

func _process(delta):
	if is_instance_valid(_activeWeapon):
		_activeWeapon.isFiring = isFiring

func pick_up_weapon(weapon: PackedScene) -> void:
	var weaponScene: WeaponBase = weapon.instance()
	if weaponScene.name in weapons.keys():
		var presentWeapon: WeaponBase = weapons[weaponScene.name]
		presentWeapon.ammunition += weaponScene.ammunition
		print('added ammunition to weapon ', weaponScene.name)
	else:
		weapons[weaponScene.name] = weaponScene
		add_child(weaponScene)
		weaponScene.set_owner(self)
		print('picked up ', weaponScene.name)
		if not is_instance_valid(_activeWeapon):
			
			switch_to_weapon(weaponScene)

func switch_to_weapon(key: int) -> void:
	
	if is_instance_valid(_activeWeapon):
		_activeWeapon.hide()
	_activeWeapon = newWeapon
	_activeWeapon.show()
	print('equipped weapon ', newWeapon.name)
