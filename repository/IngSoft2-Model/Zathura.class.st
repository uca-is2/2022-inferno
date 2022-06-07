"
i represent a game called zathura. with spaceships, a board, and dice
"
Class {
	#name : #Zathura,
	#superclass : #Object,
	#instVars : [
		'spaceshipsPositions',
		'dice',
		'board',
		'laps',
		'gameIsFinished'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Zathura class >> playedWith: aDice over: aBoard by: anAmountOfSpaceships around: anAmountOfLaps [

	anAmountOfSpaceships > 1 ifFalse: [ 
		Error signal:
			'A game cannot be created with a number of spaceships lower than two.' ].
	
	^ self new initializeGameWith: aDice over: aBoard by: anAmountOfSpaceships around: anAmountOfLaps.
	
]

{ #category : #effects }
Zathura >> applyEffect [
	| effectOfSlot |
	effectOfSlot := ((board layout at: (spaceshipsPositions currentSpaceshipPosition)) effectAtSpot) applyTo: spaceshipsPositions limitedBy: (board length).
]

{ #category : #accessing }
Zathura >> hasGameFinished [
	^ gameIsFinished.
]

{ #category : #initialization }
Zathura >> initializeGameWith: aDice over: aBoard  by: anAmountOfSpaceships around: anAmountOfLaps [
	
	dice := aDice .
	board := aBoard.
	spaceshipsPositions := GamePositions with: anAmountOfSpaceships around: anAmountOfLaps.
	gameIsFinished := false.
	
]

{ #category : #moving }
Zathura >> isLapFinishedIf: positionBeforeRoll moves: rollNumber [

	^ positionBeforeRoll + rollNumber >= (board length).
]

{ #category : #moving }
Zathura >> move: aSpaceshipID [

	| positionBeforeRoll lapBeforeRoll rollNumber |
	positionBeforeRoll := spaceshipsPositions  currentSpaceshipPosition.
	lapBeforeRoll := spaceshipsPositions currentSpaceshipLap.
	rollNumber := dice roll.
	(self isLapFinishedIf: positionBeforeRoll moves: rollNumber)
		ifTrue: [ 
			lapBeforeRoll + 1 >= spaceshipsPositions laps
				ifTrue: [ self spaceshipMovesToTheEnd ]
				ifFalse: [ 
					spaceshipsPositions moveCurrentTo: (positionBeforeRoll + rollNumber - board length) andLap:(lapBeforeRoll + 1).
					self applyEffect ] ]
		ifFalse: [ 
			spaceshipsPositions moveCurrentTo:  ( positionBeforeRoll + rollNumber).
			self applyEffect ]
]

{ #category : #playing }
Zathura >> playEntireGame [
	[ gameIsFinished  ] whileFalse: [ self playNextTurn ].
	^ spaceshipsPositions.
]

{ #category : #playing }
Zathura >> playNextTurn [
		gameIsFinished ifTrue: [ 
		Error signal: 'Game is finished! You cannot keep playing this game.' ].
	self move: (spaceshipsPositions currentSpaceshipId).
	(spaceshipsPositions currentSpaceshipPosition >= board length) & (spaceshipsPositions currentSpaceshipLap >= spaceshipsPositions laps) ifTrue: [ 
		gameIsFinished := true ].
	spaceshipsPositions nextSpaceshipInLine
]

{ #category : #moving }
Zathura >> spaceshipMovesToTheEnd [
	spaceshipsPositions moveCurrentTo: board length andLap: spaceshipsPositions laps.
]
