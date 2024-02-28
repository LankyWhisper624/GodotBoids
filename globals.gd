extends Node

# All the globals!
# Only here so the options screen can change them.
@export var globalNumBoids = 150                           # The total number of Boids
@export var globalBoidScene = preload("res://boid.tscn")   # The boid Scene. Only contains a sprite, with it's own internal velocity.
@export var globalAdhesionFactor = 0.02                    # How much the boids want to stick together
@export var globalAlignmentFactor = 0.15                   # How much the boids want to align
@export var globalRepulsionFactor = 0.25                   # How much the boids will avoid each other.
@export var globalContainmentFactor = 7.5                  # How much the boids will rebount outside of the safe area.
@export var globalSafeAreaOffset = 150                     # How far away from the edge of the screen the safe zone is.
@export var globalVisionRadius = 75                        # How far the boids can see.
@export var globalMaxVelocity = 250                        # Maximum velocity the Boids are allowed to travel.


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
