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
		'turnController',
		'spaceshipHands',
		'cardsBeingApplied'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Zathura class >> playWith: aDiceCup over: aBoard dealing: handsOfCards [

	^ self new initializeWith: aDiceCup over: aBoard dealing: handsOfCards
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

{ #category : #playing }
Zathura >> cardApplicator [
	| cardsAffectingRoll cardsAffectingAllRolls addToRoll |
	cardsAffectingRoll := (cardsBeingApplied at: (turnController activeSpaceship)).
	cardsAffectingAllRolls := (cardsBeingApplied at: 'General').
	cardsAffectingRoll addAllLast: cardsAffectingAllRolls .
	addToRoll := 0.
	1 to: (cardsAffectingRoll size) do: [ :cardNumber |
		addToRoll := ((cardsAffectingRoll at: cardNumber) effectOnRoll).
		 ].
	^ addToRoll
]

{ #category : #playing }
Zathura >> currentSpaceshipPlaysCard: aPermanentCard applyTo: aSpaceship [
	| cardToApply |
	cardToApply := (spaceshipHands at: (turnController activeSpaceship)) playCardOfType: aPermanentCard .
	(cardsBeingApplied at: aSpaceship) addLast: aPermanentCard.
]

{ #category : #getter }
Zathura >> handOf: aSpaceship [ 
	^(spaceshipHands at: aSpaceship).
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
Zathura >> initializeWith: aDiceCup over: aBoard dealing: handsOfCards [ 
	| spaceshipKeys |
	board := aBoard.
	dice := aDiceCup.
	gameIsFinished := false.
	turnController := TurnController with: aBoard spaceshipPositions.
	spaceshipHands := Dictionary new: ((aBoard spaceshipPositions) size).
	spaceshipKeys := ((aBoard spaceshipPositions) keys).
	cardsBeingApplied := Dictionary new: ((aBoard spaceshipPositions) size + 1).
	1 to: ((aBoard spaceshipPositions) size) do: [ :spaceship |
		spaceshipHands at: (spaceshipKeys at: spaceship) put: (handsOfCards at: spaceship).
		cardsBeingApplied at: (spaceshipKeys at: spaceship) put: (OrderedCollection new).
		 ].
	cardsBeingApplied at: 'General' put: (OrderedCollection new).
	
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

	| positionBeforeRoll lapBeforeRoll spotBeforeRoll rollNumber cardsEffectsOnRoll |
	self assertItIsThatSpaceshipsTurn: aSpaceship.
	positionBeforeRoll := board positionOf: aSpaceship.
	lapBeforeRoll := positionBeforeRoll lapNumber.
	spotBeforeRoll := positionBeforeRoll spotNumber.
	rollNumber := dice roll.
	cardsEffectsOnRoll := self cardApplicator.
	board
		move: aSpaceship
		fromSpot: spotBeforeRoll
		andLap: lapBeforeRoll
		to: rollNumber + cardsEffectsOnRoll .
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
