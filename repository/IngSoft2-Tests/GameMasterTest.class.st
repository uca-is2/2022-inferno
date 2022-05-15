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
	aGameMaster := GameMaster createGameWithDice: anArrayOfDieSides withBoard: 57 andNumberOfParsecs: 23 andAmountOfLaps: 3 withAmountOfSpaceships: 4.
	
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
							andNumberOfParsecs: 567
		               andAmountOfLaps:3
		               withAmountOfSpaceships: 4
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
							andNumberOfParsecs: 9696
		               andAmountOfLaps: 2
		               withAmountOfSpaceships: 4.
	aGameMaster playEntireGame.
	aGameMaster showFinalPositions
]
