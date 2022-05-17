Class {
	#name : #GameMasterTest,
	#superclass : #TestCase,
	#instVars : [
		'finalPositions'
	],
	#category : #'IngSoft2-Tests'
}

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
	self assert: aGameMaster isGameFinished 
]

{ #category : #tests }
GameMasterTest >> testGameMasterCanPlayItsGameTilTheEndOneTurnAtTheTime [

	| aGameMaster anArrayOfDieSides |
	anArrayOfDieSides := Array new: 4.
	anArrayOfDieSides at: 1 put: 6.
	anArrayOfDieSides at: 2 put: 6.
	anArrayOfDieSides at: 3 put: 6.
	anArrayOfDieSides at: 4 put: 7.
	aGameMaster := GameMaster
		               createGameWithDice: anArrayOfDieSides
		               withBoard: 50
							andNumberOfParsecs: 900
		               andAmountOfLaps: 2
		               withAmountOfSpaceships: 4.
	[aGameMaster isGameFinished] whileFalse: [
		aGameMaster playNextTurn 
		].
	self assert: aGameMaster isGameFinished.
]

{ #category : #tests }
GameMasterTest >> testGameMasterCheckPositionsIsValid [

	| aGameMaster anArrayOfDieSides |
	anArrayOfDieSides := Array new: 4.
	anArrayOfDieSides at: 1 put: 6.
	anArrayOfDieSides at: 2 put: 6.
	anArrayOfDieSides at: 3 put: 6.
	anArrayOfDieSides at: 4 put: 7.
	aGameMaster := GameMaster
		               createGameWithDice: anArrayOfDieSides
		               withBoard: 50
							andNumberOfParsecs: 900
		               andAmountOfLaps: 2
		               withAmountOfSpaceships: 4.
	1 to: 9 do: [ :turn|
		aGameMaster playNextTurn 
		 ].
	self assert: (aGameMaster spacehipsPositions) isNotNil 
]
