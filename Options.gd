extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print('pausing...')
	get_tree().paused = true
	updateText()

func updateText():
	$"VBoxContainer/Num Boids".text = str(Globals.globalNumBoids)
	$"VBoxContainer/Adhesion Factor".text = str(Globals.globalAdhesionFactor)
	$"VBoxContainer/Alignment Factor".text = str(Globals.globalAlignmentFactor)
	$"VBoxContainer/Repulsion Factor".text = str(Globals.globalRepulsionFactor)
	$"VBoxContainer/Containment Factor".text = str(Globals.globalContainmentFactor)
	$"VBoxContainer/Safe Area".text = str(Globals.globalSafeAreaOffset)
	$"VBoxContainer/Vision Radius".text = str(Globals.globalVisionRadius)
	$"VBoxContainer/Max Velocity".text =str(Globals.globalMaxVelocity)


func updateVars():
	Globals.globalNumBoids = $"VBoxContainer/Num Boids".text.to_int()
	Globals.globalAdhesionFactor = float($"VBoxContainer/Adhesion Factor".text)
	Globals.globalAlignmentFactor = float($"VBoxContainer/Alignment Factor".text)
	Globals.globalRepulsionFactor = float($"VBoxContainer/Repulsion Factor".text)
	Globals.globalContainmentFactor = float($"VBoxContainer/Containment Factor".text)
	Globals.globalSafeAreaOffset = $"VBoxContainer/Safe Area".text.to_int()
	Globals.globalVisionRadius = $"VBoxContainer/Vision Radius".text.to_int()
	Globals.globalMaxVelocity = float($"VBoxContainer/Max Velocity".text)



func _on_Button_pressed():
	updateVars()
	get_tree().paused = false
	print('resuming...')
	get_tree().change_scene_to_file("res://main.tscn")


func _on_Exit_pressed():
	get_tree().quit()
