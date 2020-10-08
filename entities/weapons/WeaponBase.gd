extends Spatial
class_name WeaponBase

export var weaponName: String = 'BaseWeapon'
export var bulletScene: PackedScene
export var automaticFireMode: bool = true
export var fireDelay: float = 0.1
export var ammunition: int = 10  # amount of ammu the weapon has by default.
export var spread: float = 0.2

var isFiring: bool = false
var _wasFiring: bool = false
onready var _projectileTimer: Timer = $LoadProjectileTimer
onready var _projectileSpawnPoint: Position3D = $ProjectileSpawnPoint


func _ready():
	name = weaponName
	if automaticFireMode:
		_projectileTimer.connect("timeout", self, "_fire_projectile")
		_projectileTimer.one_shot = false
	else:
		_projectileTimer.one_shot = true


func _process(_delta):
	if isFiring and not _wasFiring:
		_wasFiring = true
		_start_firing()
		
	if not isFiring and _wasFiring:
		_wasFiring = false
		_end_firing()


func _start_firing():
	if _projectileTimer.time_left == 0:
		_fire_projectile()
		_projectileTimer.start(fireDelay)

	
func _end_firing():
	if automaticFireMode:
		_projectileTimer.disconnect("timeout", self, "_fire_projectile")
		_projectileTimer.connect("timeout", self, "_reset_timer")


func _reset_timer():
	_projectileTimer.stop()
	_projectileTimer.disconnect("timeout", self, "_reset_timer")
	_projectileTimer.connect("timeout", self, "_fire_projectile")


func _fire_projectile():
	if ammunition > 0:
		_spawn_projectile()
		ammunition -= 1
	else:
		print('out of ammu..')

func _spawn_projectile() -> void:
	var bullet: RigidBody = bulletScene.instance()
	add_child(bullet)
	bullet.set_owner(self)
	bullet.set_as_toplevel(true)
	
	var basis: Basis = _projectileSpawnPoint.global_transform.basis
	basis = basis.rotated(Vector3(0, 1, 0), randf()*spread)
	basis = basis.rotated(Vector3(0, 0, 1), randf()*spread)
	bullet.global_transform.origin = _projectileSpawnPoint.global_transform.origin
	
	bullet.apply_central_impulse(basis.x * 50)
