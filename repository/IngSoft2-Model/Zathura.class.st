"
i represent a Zathura: Inferno game.
"
Class {
	#name : #Zathura,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice',
		'gameIsFinished',
		'turnController'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Zathura class >> playWith: aDiceCup over: aBoard [ 
	^self new initializeWith: aDiceCup over: aBoard.
]

{ #category : #playing }
Zathura >> assertGameIsFinished [

	gameIsFinished ifTrue: [ 
		Error signal: 'Game is finished! You cannot keep playing this game.' ]
]

{ #category : #playing }
Zathura >> assertItIsThatSpaceshipsTurn: aSpaceship [

	aSpaceship == turnController activeSpaceship ifFalse: [ 
		Error signal: 'Cannot play turn if it is not that spaceship turn.' ]
]

{ #category : #getters }
Zathura >> hasGameFinished [
	^ gameIsFinished.
]

{ #category : #playing }
Zathura >> hasItReachedTheFinishLine: currentSpaceship [

	(board positionOf: currentSpaceship) spotNumber >= (board lengthInSpots)
	& ((board positionOf: currentSpaceship) lapNumber >= board amountOfLaps) 
		ifTrue: [ gameIsFinished := true ]
]

{ #category : #initialization }
Zathura >> initializeWith: aDiceCup over: aBoard [ 
	board := aBoard.
	dice := aDiceCup.
	gameIsFinished := false.
	turnController := TurnController with: aBoard spaceshipPositions  .
]

{ #category : #playing }
Zathura >> playNextTurn [

	| currentSpaceship |
	self assertGameIsFinished.
	currentSpaceship := turnController activeSpaceship.
	self playTurn: currentSpaceship.
]

{ #category : #playing }
Zathura >> playTurn: aSpaceship [

	| positionBeforeRoll lapBeforeRoll spotBeforeRoll rollNumber |
	self assertItIsThatSpaceshipsTurn: aSpaceship.
	positionBeforeRoll := board positionOf: aSpaceship.
	lapBeforeRoll := positionBeforeRoll lapNumber.
	spotBeforeRoll := positionBeforeRoll spotNumber.
	rollNumber := dice roll.
	board
		move: aSpaceship
		fromSpot: spotBeforeRoll
		andLap: lapBeforeRoll
		to: rollNumber.
	self hasItReachedTheFinishLine: aSpaceship.
	turnController nextSpaceshipInLine
]

{ #category : #getter }
Zathura >> positionOf: aSpaceship [	
	 ^board positionOf: aSpaceship.
]

{ #category : #getter }
Zathura >> rankingOfSpaceships [
	^board rankingOfSpaceships .
]
