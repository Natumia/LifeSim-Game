extends KinematicBody2D

# Get's the state machine to use travel function.
onready var animState = $AnimationTree["parameters/playback"]
onready var emote = preload("res://Characters/Emotes/Emote.tscn")

var velocity = Vector2.ZERO
var moveSpeed = 70

var canEmote = true

func _ready():
	# Starts animation Tree because it's off in editor.
	$AnimationTree.active = true

func _physics_process(_delta):
	player_movement()
	player_emote()

func player_movement():
	var inputVector = Vector2.ZERO
	
	# Checks input vector by pitting directions against each other. Normalizes
	# the vector afterwards.
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()
	
	# Sets direction of animations. Travels appropriately based on input vector.
	if inputVector != Vector2.ZERO:
		animState.travel("Move")
		$AnimationTree["parameters/Move/blend_position"] = inputVector
		$AnimationTree["parameters/Idle/blend_position"] = inputVector
	else:
		animState.travel("Idle")
	
	velocity = inputVector * moveSpeed
	velocity = move_and_slide(velocity)

# The emote functions are temporary, they're fun to add in but I want to make it
# as a base function for character class. Huzzah!
func player_emote():
	if canEmote != false:
		if Input.is_action_just_pressed("emote_love"):
			var newEmote = emote.instance()
			add_child(newEmote)
			newEmote.connect("emote_done", self, "_emote_finished")
			newEmote.animation = "Love"
			canEmote = false
		if Input.is_action_just_pressed("emote_anger"):
			var newEmote = emote.instance()
			add_child(newEmote)
			newEmote.connect("emote_done", self, "_emote_finished")
			newEmote.animation = "Anger"
			canEmote = false
		if Input.is_action_just_pressed("emote_sad"):
			var newEmote = emote.instance()
			add_child(newEmote)
			newEmote.connect("emote_done", self, "_emote_finished")
			newEmote.animation = "Sad"
			canEmote = false
		if Input.is_action_just_pressed("emote_happy"):
			var newEmote = emote.instance()
			add_child(newEmote)
			newEmote.connect("emote_done", self, "_emote_finished")
			newEmote.animation = "Happy"
			canEmote = false

func _emote_finished():
	canEmote = true
