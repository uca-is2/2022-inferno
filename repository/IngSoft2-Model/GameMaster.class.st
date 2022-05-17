"
I represent a GameMaster, whose function is to create a game, and can show or return the winners and the podium.
"
Class {
	#name : #GameMaster,
	#superclass : #Object,
	#instVars : [
		'currentGame',
		'finalPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
GameMaster class >> createGameWithDice: anArrayOfDiceSides withBoard: aNumberOfSlots andNumberOfParsecs: amountOfParsecs andAmountOfLaps: aNumberOfLaps withAmountOfSpaceships: anAmountOfSpaceships [

	^ self new
		  initializeWithDice: anArrayOfDiceSides
		  withBoard: aNumberOfSlots
		  andNumberOfParsecs: amountOfParsecs
		  andAmountOfLaps: aNumberOfLaps 
		  withAmountOfSpaceships: anAmountOfSpaceships
]

{ #category : #initialization }
GameMaster >> initializeWithDice: anArrayOfDieSides withBoard: aNumberOfSlots andNumberOfParsecs: amountOfParsecs andAmountOfLaps: aNumberOfLaps withAmountOfSpaceships: anAmountOfSpaceships [

	| aCollectionOfDice aDie index aBoard aDiceCup |
	index := 1.
	aCollectionOfDice := Array new: anArrayOfDieSides size.
	anArrayOfDieSides do: [ :aNumberOfDieSides | 
		aDie := Die with: aNumberOfDieSides.
		aCollectionOfDice at: index put: aDie.
		index := index + 1 ].
	aBoard := Board with: aNumberOfSlots andNumberOfParsecs: amountOfParsecs.
	aDiceCup := DiceCup with: aCollectionOfDice.
	currentGame := Game withDice: aDiceCup withBoard: aBoard andAmountOfLaps: aNumberOfLaps withAmountOfSpaceships: anAmountOfSpaceships.
	
]

{ #category : #testing }
GameMaster >> isGameFinished [
	^currentGame hasGameFinished.
]

{ #category : #playing }
GameMaster >> playEntireGame [
	finalPositions := currentGame playEntireGame.
]

{ #category : #playingByTurns }
GameMaster >> playNextTurn [
	currentGame playNextTurn.
]

{ #category : #showing }
GameMaster >> showFinalPositions [
	^ finalPositions
]

{ #category : #showing }
GameMaster >> spacehipsPositions [
	^ currentGame spaceshipPositioning.
]
