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
		'currentSpaceshipID'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> withDice: aDice withBoard: aBoard withAmountOfSpaceships: aNumberOfSpaceships [

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
		  withAmountOfSpaceships: aNumberOfSpaceships
]

{ #category : #accessing }
Game >> hasGameFinished [
	^ isGameFinished.
]

{ #category : #initialization }
Game >> initializeWithDice: aDice withBoard: aBoard withAmountOfSpaceships: aNumberOfSpaceships [
 
	spaceshipsPositions := Dictionary new.
	1 to: aNumberOfSpaceships do: [ :spaceshipID | spaceshipsPositions at: spaceshipID put: 0 ].
	currentSpaceshipID := 1. 
	dice := aDice .
	board := aBoard .
	isGameFinished := false.
	
]

{ #category : #movement }
Game >> move: aSpaceshipID [

	| positionBeforeRoll rollNumber |
	positionBeforeRoll := spaceshipsPositions at: currentSpaceshipID.
	rollNumber := dice roll.
	positionBeforeRoll + rollNumber >= board lenght
		ifTrue: [ 
			spaceshipsPositions at: currentSpaceshipID put: board lenght ]
		ifFalse: [ 
			spaceshipsPositions at: currentSpaceshipID put: positionBeforeRoll + rollNumber ]
]

{ #category : #iteration }
Game >> nextSpaceshipInLine [
   currentSpaceshipID :=currentSpaceshipID  + 1.
   (currentSpaceshipID > spaceshipsPositions  size) ifTrue: [ currentSpaceshipID :=1 ].
]

{ #category : #playing }
Game >> playEntireGame [
	[isGameFinished] whileFalse: [ self playNextTurn ].
	^'Game has finished!.'.
]

{ #category : #playingByTurns }
Game >> playNextTurn [
	(isGameFinished) ifTrue: [ Error signal: 'Game is finished! You cannot keep playing this game.'].
	(isGameFinished) ifFalse: [ self move: currentSpaceshipID ].
	(spaceshipsPositions at: currentSpaceshipID ) >= board lenght ifTrue: [ 
		isGameFinished := true ].
	self nextSpaceshipInLine.
]
