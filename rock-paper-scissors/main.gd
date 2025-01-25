extends Node2D

enum Picks { ROCK, PAPER, SCISSORS }
enum States { IDLE, PICKING, PICKED, PLAYING }

const RULES := {
	"ROCK": "SCISSORS",
	"PAPER": "ROCK",
	"SCISSORS": "PAPER",
} # Key wins against the value!

var curState := States.IDLE
var choice : Picks
@onready var Text = $Label

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("proceed"):
		match curState:
			States.IDLE:
				Text.text = "Select a pick.\n1- Rock, 2 - Paper, 3 - Scissors"
				curState = States.PICKING
			States.PICKED:
				startGame()
				curState = States.IDLE
	elif event.is_action_pressed("rock"):
		selectPick(Picks.ROCK)
	elif event.is_action_pressed("paper"):
		selectPick(Picks.PAPER)
	elif event.is_action_pressed("scissors"):
		selectPick(Picks.SCISSORS)

func selectPick(pick: Picks):
	if curState == States.PICKING:
		curState = States.PICKED
		choice = pick
		Text.text = "You picked " + Picks.keys()[choice] + ".\n Press SPACE to proceed."

func startGame():
	curState = States.PLAYING
	#const PickDictionary := ["Rock", "Paper", "Scissors"]
	var enemyPick = Picks.keys()[getEnemyChoice()]
	var playerPick = Picks.keys()[choice]
	
	if RULES[playerPick] == enemyPick:
		Text.text = "You won!\n" + "(" + playerPick + " VS " + enemyPick + ")"
	elif RULES[enemyPick] == playerPick:
		Text.text = "You lost...\n" + "(" + playerPick + " VS " + enemyPick + ")"
	else:
		Text.text = "It's a tie.\n" + "(" + playerPick + " VS " + enemyPick + ")"
	
func getEnemyChoice() -> int :
	var enemyChoice = randi_range(0, 2)
	return enemyChoice
