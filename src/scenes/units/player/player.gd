extends Unit


const GRAVITY: float = 300.0;
const WALK_SPEED: float = 300.0;
const JUMP_SPEED: float = 350.0;
const EXPLOSIVE_PROJECTILE = preload("res://scenes/projectile/explosive_proj.tscn")
const BOOMERANG_PROJECTILE = preload("res://scenes/projectile/boomerang.tscn")
const PROJECTILE_OFFSET: float = 60.0;
const NORMAL: Vector2 = Vector2(0, -1);

var PROJECTILE = null;

var velocity: Vector2 = Vector2(0, 0);
var can_attack = true;


# Called when the node enters the scene tree for the first time.
func _ready():
	set_meta("type", "player");
	PROJECTILE = EXPLOSIVE_PROJECTILE;


func _physics_process(delta):

	process_attack_loadout();
	process_atk();
	$Sprite/Weapon.visible = can_attack;

	process_movement(delta);

	if velocity.x != 0:
		$Sprite.scale.x = -sign(velocity.x) * abs($Sprite.scale.x);


func process_movement(delta):

	velocity.y += delta * GRAVITY;

	if Input.is_action_pressed("ui_left"):	
		velocity.x = -WALK_SPEED;
	elif Input.is_action_pressed("ui_right"):
		velocity.x = WALK_SPEED;
	else:
		velocity.x = 0;

	velocity = move_and_slide(velocity, NORMAL);

	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y -= JUMP_SPEED;


func process_atk():
	if Input.is_action_just_pressed("player_atk"):
		if can_attack:
			var atk_proj = PROJECTILE.instance()
			atk_proj.PLAYER = self
			atk_proj.position =  get_projectile_spawn_pos()
			get_parent().add_child(atk_proj)
			can_attack = false


func get_projectile_spawn_pos():
	return position + (get_global_mouse_position() - global_position).normalized() * PROJECTILE_OFFSET
	

func process_attack_loadout():
	# Changing loadout is only for debugging. Actual gameplay won't let you do
	# this except in certain checkpoint.
	if Input.is_action_just_pressed("player_changeatk"):
		print("change_loadout")
		if PROJECTILE == EXPLOSIVE_PROJECTILE:
			PROJECTILE = BOOMERANG_PROJECTILE
			print("change to boomerang")
		elif PROJECTILE == BOOMERANG_PROJECTILE:
			PROJECTILE = EXPLOSIVE_PROJECTILE
			print("change to explosive")
			
	# change text
	if PROJECTILE == EXPLOSIVE_PROJECTILE:
		$Label.text = "Explosive"
	if PROJECTILE == BOOMERANG_PROJECTILE:
		$Label.text = "Boomerang"
