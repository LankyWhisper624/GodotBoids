extends Node2D

var numBoids = Globals.globalNumBoids                       # The total number of Boids
var boidScene = Globals.globalBoidScene                     # The boid Scene. Only contains a sprite, with it's own internal velocity.
var adhesionFactor = Globals.globalAdhesionFactor           # How much the boids want to stick together
var alignmentFactor = Globals.globalAlignmentFactor         # How much the boids want to align
var repulsionFactor = Globals.globalRepulsionFactor         # How much the boids will avoid each other.
var containmentFactor = Globals.globalContainmentFactor     # How much the boids will rebount outside of the safe area.
var safeAreaOffset = Globals.globalSafeAreaOffset           # How far away from the edge of the screen the safe zone is.
var visionRadius = Globals.globalVisionRadius               # How far the boids can see.
var maxVelocity = Globals.globalMaxVelocity                 # Maximum velocity the Boids are allowed to travel.
var newVel = Vector2.ZERO

func _ready():
	updateVars()
	var instance = boidScene.instantiate()
	for _i in range(numBoids):
#        print("Instancing boid #", i, "...");
		add_child(instance, true)
		instance = boidScene.instantiate()
		instance.position = Vector2(randf_range(safeAreaOffset, get_viewport_rect().size.x - safeAreaOffset),
									randf_range(safeAreaOffset, get_viewport_rect().size.y - safeAreaOffset))
	print("Instanced ", numBoids, " boids")

func updateVars():
	numBoids = Globals.globalNumBoids                       # The total number of Boids
	boidScene = Globals.globalBoidScene                     # The boid Scene. Only contains a sprite, with it's own internal velocity.
	adhesionFactor = Globals.globalAdhesionFactor           # How much the boids want to stick together
	alignmentFactor = Globals.globalAlignmentFactor         # How much the boids want to align
	repulsionFactor = Globals.globalRepulsionFactor         # How much the boids will avoid each other.
	containmentFactor = Globals.globalContainmentFactor     # How much the boids will rebount outside of the safe area.
	safeAreaOffset = Globals.globalSafeAreaOffset           # How far away from the edge of the screen the safe zone is.
	visionRadius = Globals.globalVisionRadius               # How far the boids can see.
	maxVelocity = Globals.globalMaxVelocity                 # Maximum velocity the Boids are allowed to travel.

func move(currentBoid):
	currentBoid.velocity = (currentBoid.velocity + newVel).limit_length(maxVelocity)
#	currentBoid.rotation = currentBoid.velocity.angle() + PI/2
#	currentBoid.position += currentBoid.velocity * delta

func constrain(currentBoid):
	if currentBoid.position.x < 0 + safeAreaOffset:
		newVel.x += containmentFactor
	if currentBoid.position.x > get_viewport_rect().size.x - safeAreaOffset:
		newVel.x -= containmentFactor
	if currentBoid.position.y < 0 + safeAreaOffset:
		newVel.y += containmentFactor
	if currentBoid.position.y > get_viewport_rect().size.y - safeAreaOffset:
		newVel.y -= containmentFactor

func adhere(currentBoid):
	# print(currentBoid)
	var boidsSeen = 0
	var totalPos = Vector2.ZERO
	var averagePos = Vector2.ZERO
	var adhesionVel = Vector2.ZERO
	for x in get_children():
		if x == $VBoxContainer or x == $VBoxContainer/exit or x == $VBoxContainer/menu:
			continue
		if (currentBoid != x) && ( currentBoid.position.distance_to(x.position) < visionRadius ):
			totalPos += currentBoid.position
			boidsSeen += 1
	if boidsSeen != 0 :
		averagePos = totalPos / boidsSeen
	else:
		averagePos = currentBoid.position
#    print(boidsSeen)
	adhesionVel = currentBoid.position - averagePos
	newVel += adhesionVel * adhesionFactor

func repulse(currentBoid):
	var repulsionVel = Vector2.ZERO
	for x in get_children():
		if x == $VBoxContainer or x == $VBoxContainer/exit or x == $VBoxContainer/menu:
			continue
		if (currentBoid != x) && (currentBoid.position.distance_to(x.position) < visionRadius):
			repulsionVel = ( currentBoid.position - x.position ) * ((visionRadius) / currentBoid.position.distance_to(x.position))
	newVel += repulsionVel * repulsionFactor

func align(currentBoid):
	var boidsSeen = 0
	var averageVel = Vector2.ZERO
	var totalVel = Vector2.ZERO
	for x in get_children():
		if x == $VBoxContainer or x == $VBoxContainer/exit or x == $VBoxContainer/menu:
			continue
		if (currentBoid != x) && (currentBoid.position.distance_to(x.position) < visionRadius ):
			totalVel += x.velocity
			boidsSeen += 1
	if boidsSeen != 0:
		averageVel = totalVel / boidsSeen
	else:
		averageVel = Vector2.ZERO
	newVel += averageVel * alignmentFactor

func pause():
	get_tree().change_scene_to_file("res://Options.tscn")

func _process(_delta):
	if Input.is_action_pressed("open_options"):
		pause()
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	for i in get_children():
		# print(i)
		if i == $VBoxContainer or i == $VBoxContainer/exit or i == $VBoxContainer/menu:
			continue
		newVel = Vector2.ZERO
		adhere(i)
		repulse(i)
		align(i)
		constrain(i)
		move(i)

func _on_menu_pressed():
	pause()

func _on_exit_pressed():
	get_tree().quit()
