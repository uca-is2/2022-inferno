"
I represent a Game that has dice, a board and amount of spaceships
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'board',
		'isGameFinished',
		'spaceshipsPositions',
		'currentSpaceshipID',
		'numberOfLaps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> withDice: aDice withBoard: aBoard andAmountOfLaps: aNumberOfLaps withAmountOfSpaceships: aNumberOfSpaceships [

	aNumberOfSpaceships > 1 ifFalse: [ 
		Error signal:
			'A game cannot be created with a number of spaceships lower than two.' ].

	(aDice isKindOf: DiceCup) | (aDice isKindOf: Die) ifFalse: [ 
		Error signal: 'A game cannot be created without dice.' ].

	(aBoard isKindOf: Board) ifFalse: [ 
		Error signal: 'A game cannot be created without a board.' ].

	^ self new
		  initializeWithDice: aDice
		  withBoard: aBoard
		  andAmountOfLaps: aNumberOfLaps 
		  withAmountOfSpaceships: aNumberOfSpaceships
]

{ #category : #accessing }
Game >> hasGameFinished [
	^ isGameFinished.
]

{ #category : #initialization }
Game >> initializeWithDice: aDice withBoard: aBoard andAmountOfLaps: aNumberOfLaps withAmountOfSpaceships: aNumberOfSpaceships [

	spaceshipsPositions := Dictionary new.
	1 to: aNumberOfSpaceships do: [ :spaceshipID | 
	spaceshipsPositions at: spaceshipID put: (Array new: 2).
	spaceshipsPositions at: spaceshipID at: 1 put: 0.
	spaceshipsPositions at: spaceshipID at: 2 put: 0.].
	currentSpaceshipID := 1.
	dice := aDice.
	board := aBoard.
	numberOfLaps := aNumberOfLaps.
	isGameFinished := false
]

{ #category : #movement }
Game >> move: aSpaceshipID [

	| positionBeforeRoll lapBeforeRoll rollNumber |
	positionBeforeRoll := spaceshipsPositions at: currentSpaceshipID at:1.
	lapBeforeRoll := spaceshipsPositions at: currentSpaceshipID at:2.
	rollNumber := dice roll.
	positionBeforeRoll + rollNumber >= board lenght
		ifTrue: [ 
			(lapBeforeRoll + 1 >= numberOfLaps) 
				ifTrue: [ 
					spaceshipsPositions at: currentSpaceshipID at: 2 put: numberOfLaps.
					spaceshipsPositions at: currentSpaceshipID at: 1 put: board lenght.
					 ]
				ifFalse: [ 
					spaceshipsPositions at: currentSpaceshipID at: 2 put: (lapBeforeRoll+1). 
					spaceshipsPositions at: currentSpaceshipID at: 1 put: (positionBeforeRoll + rollNumber - board lenght).
					 ].
			 ]
		ifFalse: [ 
			spaceshipsPositions at: currentSpaceshipID at: 1 put: positionBeforeRoll + rollNumber ]
]

{ #category : #iteration }
Game >> nextSpaceshipInLine [
   currentSpaceshipID := currentSpaceshipID  + 1.
   (currentSpaceshipID > spaceshipsPositions  size) ifTrue: [ currentSpaceshipID :=1 ].
]

{ #category : #playing }
Game >> playEntireGame [
	[isGameFinished] whileFalse: [ self playNextTurn ].
	^spaceshipsPositions.
]

{ #category : #playingByTurns }
Game >> playNextTurn [
	(isGameFinished) ifTrue: [ Error signal: 'Game is finished! You cannot keep playing this game.'].
	(isGameFinished) ifFalse: [ self move: currentSpaceshipID ].
	((spaceshipsPositions at: currentSpaceshipID at: 1 ) >= board lenght) & ((spaceshipsPositions at: currentSpaceshipID at: 2 ) >= numberOfLaps)  ifTrue: [ 
		isGameFinished := true ].
	self nextSpaceshipInLine.
]
