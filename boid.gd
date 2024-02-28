extends Node2D

@export var randomFactor = 100;
var velocity = Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(randf_range(-1, 1)*randomFactor, randf_range(-1, 1)*randomFactor);
   

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = velocity.angle() + PI/2
	position += velocity * delta
