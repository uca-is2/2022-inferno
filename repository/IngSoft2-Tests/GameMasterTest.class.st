Class {
	#name : #GameMasterTest,
	#superclass : #TestCase,
	#instVars : [
		'newGame'
	],
	#classVars : [
		'GameBoard',
		'GameDiceCup'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameMasterTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ].

	self assert: errorWasRaised.
	self assert: errorMessage equals: expectedErrorMessage
]

{ #category : #tests }
GameMasterTest >> testCreateGameIsValid [

	| aGameMaster |
	aGameMaster := newGame.
	self assert: GameMaster hasGame.
]

{ #category : #tests }
GameMasterTest >> testCreateGameMasterWithAValidBoardIsValid [

	| aGameMaster |
	aGameMaster := GameMaster.
	aGameMaster newBoard: 20.
	self assert: GameMaster hasBoard
]

{ #category : #tests }
GameMasterTest >> testCreateGameMasterWithAValidDiceCupIsValid [

	| aGameMaster |
	aGameMaster := GameMaster.
	aGameMaster newDiceCup: #(4 5 6 7).
	self assert: GameMaster hasDiceCup
]

{ #category : #tests }
GameMasterTest >> testCreateGameMasterWithAnInvalidBoardIsInValid [

	| aGameMaster |
	aGameMaster := GameMaster.
	self
		should: [ aGameMaster newBoard: 2 ]
		raise: Error
		withMessage: 'Minimun length should be more than three'
]

{ #category : #tests }
GameMasterTest >> testCreateGameMasterWithAnInvalidDiceCupIsInValid [

	| aGameMaster |
	aGameMaster := GameMaster.
	self
		should: [ aGameMaster newDiceCup: #(1,2,3)]
		raise: Error
		withMessage: 'Die cannot be created with a number of sides lower than 3'
]

{ #category : #tests }
GameMasterTest >> testCreateGameMasterWithThreePlayers [

	| aGameMaster |
	aGameMaster := GameMaster.
	aGameMaster playingWith: 3.
	self assert: GameMaster hasThreePlayers
]

{ #category : #tests }
GameMasterTest >> testGameMasterPlaysGameToFinish [

	| aGameMaster |
	aGameMaster := GameMaster.
	aGameMaster newBoard: 30.
	aGameMaster newDiceCup: #(6).
	aGameMaster playingWith: 6.
	aGameMaster playGame.
	self assert: (aGameMaster gameHasFinished).
]

{ #category : #tests }
GameMasterTest >> testGameMasterShowsPlayersFinishingPositionsIsValid [

	| aGameMaster positions |
	aGameMaster := GameMaster.
	aGameMaster newBoard: 10.
	aGameMaster newDiceCup: #(6).
	aGameMaster playingWith: 2.
	aGameMaster playGame.
	positions := aGameMaster showPositions.
	self assert: (aGameMaster positionsAfterFinishIsValid: positions).
]

{ #category : #tests }
GameMasterTest >> testGameMasterShowsWinnerIsValid [

	| aGameMaster winner |
	aGameMaster := GameMaster.
	aGameMaster newBoard: 20.
	aGameMaster newDiceCup: #(6).
	aGameMaster playingWith: 3.
	aGameMaster playGame.
	winner := aGameMaster showTheWinner.
	self assert: (winner > 0).
]
