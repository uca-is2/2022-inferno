Class {
	#name : #GameMasterTest,
	#superclass : #TestCase,
	#instVars : [
		'finalPositions'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameMasterTest >> testGameMasterCanCreateAGame [
	
	| aGameMaster anArrayOfDieSides |
	anArrayOfDieSides := Array new: 2.
	anArrayOfDieSides at: 1 put: 6.
	anArrayOfDieSides at: 2 put: 6.
	aGameMaster := GameMaster createGameWithDice: anArrayOfDieSides withBoard: 57 andAmountOfLaps: 3 withAmountOfplayers: 4.
	
]

{ #category : #tests }
GameMasterTest >> testGameMasterCanCreateAGameWithAnArrayOfNumberOfSidesOfADieOfUnknownSize [

	| aGameMaster anArrayOfDieSides |
	anArrayOfDieSides := Array new: 4.
	anArrayOfDieSides at: 1 put: 6.
	anArrayOfDieSides at: 2 put: 6.
	anArrayOfDieSides at: 3 put: 6.
	anArrayOfDieSides at: 4 put: 7.
	aGameMaster := GameMaster
		               createGameWithDice: anArrayOfDieSides
		               withBoard: 50
		               andAmountOfLaps:3
		               withAmountOfplayers: 4
]

{ #category : #tests }
GameMasterTest >> testGameMasterCanPlayItsGameTilTheEnd [

	| aGameMaster anArrayOfDieSides |
	anArrayOfDieSides := Array new: 4.
	anArrayOfDieSides at: 1 put: 6.
	anArrayOfDieSides at: 2 put: 6.
	anArrayOfDieSides at: 3 put: 6.
	anArrayOfDieSides at: 4 put: 7.
	aGameMaster := GameMaster
		               createGameWithDice: anArrayOfDieSides
		               withBoard: 50
		               andAmountOfLaps: 2
		               withAmountOfplayers: 4.
	aGameMaster playEntireGame.
	aGameMaster showFinalPositions
]
