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
GameMaster class >> createGameWithDice: anArrayOfDiceSides withBoard: aNumberOfSlots andAmountOfLaps: aNumberOfLaps withAmountOfplayers: anAmountOfSpaceships [

	^ self new
		  initializeWithDice: anArrayOfDiceSides
		  withBoard: aNumberOfSlots
		  andAmountOfLaps: aNumberOfLaps 
		  withAmountOfSpaceships: anAmountOfSpaceships
]

{ #category : #initialization }
GameMaster >> initializeWithDice: anArrayOfDieSides withBoard: aNumberOfSlots andAmountOfLaps: aNumberOfLaps withAmountOfSpaceships: anAmountOfSpaceships [

	| aCollectionOfDice aDie index aBoard aDiceCup |
	index := 1.
	aCollectionOfDice := Array new: anArrayOfDieSides size.
	anArrayOfDieSides do: [ :aNumberOfDieSides | 
		aDie := Die with: aNumberOfDieSides.
		aCollectionOfDice at: index put: aDie.
		index := index + 1 ].
	aBoard := Board with: aNumberOfSlots.
	aDiceCup := DiceCup with: aCollectionOfDice.
	currentGame := Game withDice: aDiceCup withBoard: aBoard andAmountOfLaps: aNumberOfLaps withAmountOfSpaceships: anAmountOfSpaceships.
	
]

{ #category : #playing }
GameMaster >> playEntireGame [
	finalPositions := currentGame playEntireGame.
]

{ #category : #showing }
GameMaster >> showFinalPositions [
	^ finalPositions
]
