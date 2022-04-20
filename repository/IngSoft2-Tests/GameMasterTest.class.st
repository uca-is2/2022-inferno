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
GameMasterTest >> testANewGameMaster [

	|aGameMaster|
	aGameMaster:= GameMaster newGameMaster.
	aGameMaster newBoard: 20.
	self assert: (aGameMaster hasBoard).
]

{ #category : #tests }
GameMasterTest >> testCheckIfGameHasNotFinished [
	|aGameMaster|

	aGameMaster:= GameMaster newGameMaster.
	aGameMaster newBoard: 20.
	aGameMaster newLoadedDiceCup: #(9).
	aGameMaster playingWith: 3.
	aGameMaster playNextTurn.
	aGameMaster playNextTurn.
	aGameMaster playNextTurn.
	aGameMaster playNextTurn.
	self deny: (aGameMaster hasGameFinished).


]

{ #category : #tests }
GameMasterTest >> testCreateGameIsValid [

	| aGameMaster |
	aGameMaster:= GameMaster newGameMaster.
	self assert: aGameMaster hasGame.
]

{ #category : #tests }
GameMasterTest >> testCreateGameMasterWithAValidBoardIsValid [

	| aGameMaster |
	aGameMaster:= GameMaster newGameMaster.
	aGameMaster newBoard: 20.
	self assert: aGameMaster hasBoard
]

{ #category : #tests }
GameMasterTest >> testCreateGameMasterWithAValidDiceCupIsValid [

	| aGameMaster |
	aGameMaster:= GameMaster newGameMaster.
	aGameMaster newDiceCup: #(4 5 6 7).
	self assert: aGameMaster hasDiceCup
]

{ #category : #tests }
GameMasterTest >> testCreateGameMasterWithAnInvalidBoardIsInValid [

	| aGameMaster |
	aGameMaster:= GameMaster newGameMaster.
	self
		should: [ aGameMaster newBoard: 2 ]
		raise: Error
		withMessage: 'Minimun length should be more than three'
]

{ #category : #tests }
GameMasterTest >> testCreateGameMasterWithAnInvalidDiceCupIsInValid [

	| aGameMaster |
	aGameMaster:= GameMaster newGameMaster.
	self
		should: [ aGameMaster newDiceCup: #(1,2,3)]
		raise: Error
		withMessage: 'Die cannot be created with a number of sides lower than 3'
]

{ #category : #tests }
GameMasterTest >> testCreateGameMasterWithThreePlayers [

	| aGameMaster |
	aGameMaster:= GameMaster newGameMaster.
	aGameMaster playingWith: 3.
	self assert: aGameMaster hasThreePlayers
]

{ #category : #tests }
GameMasterTest >> testGameMasterPlaysGameToFinish [

	| aGameMaster |
	aGameMaster:= GameMaster newGameMaster.
	aGameMaster newBoard: 30.
	aGameMaster newDiceCup: #(6).
	aGameMaster playingWith: 6.
	aGameMaster playGame.
	self assert: (aGameMaster gameHasFinished).
]

{ #category : #tests }
GameMasterTest >> testGameMasterShowsPlayersFinishingPositionsIsValid [

	| aGameMaster positions |
	aGameMaster:= GameMaster newGameMaster.
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
	aGameMaster:= GameMaster newGameMaster.
	aGameMaster newBoard: 20.
	aGameMaster newDiceCup: #(6).
	aGameMaster playingWith: 3.
	aGameMaster playGame.
	winner := aGameMaster showTheWinner.
	self assert: (winner > 0).
]

{ #category : #tests }
GameMasterTest >> testPlayOnlyOneTurnWithLoadedDiceCupIsValid [

	|aGameMaster|

	aGameMaster:= GameMaster newGameMaster.
	aGameMaster newBoard: 20.
	aGameMaster newLoadedDiceCup: #(9).
	aGameMaster playingWith: 3.
	aGameMaster playNextTurn.
	self assert: (aGameMaster playerOneHasMovedSpots: 9).



]

{ #category : #tests }
GameMasterTest >> testRollAfterGameIsFinishedIsNotValid [

	| aGameMaster |
	aGameMaster := GameMaster newGameMaster.
	aGameMaster newBoard: 100.
	aGameMaster playingWith: 5.
	aGameMaster newLoadedDiceCup: #( 30 10 1 ).
	aGameMaster playGame.
	self
		should: [ aGameMaster playNextTurn ]
		raise: Error
		withMessage: 'Game has already finished, you can not keep playing'
]
