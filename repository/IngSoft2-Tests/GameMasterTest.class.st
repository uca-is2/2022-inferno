Class {
	#name : #GameMasterTest,
	#superclass : #TestCase,
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
GameMasterTest >> testCreateGameMasterWithAValidBoardIsValid [

	| aGameMaster |
	aGameMaster := GameMaster.
	aGameMaster newBoard: 20.
	self assert: GameMaster hasBoard
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
	aGameMaster playingWith: 3.
	aGameMaster playGame.
	self assert: (aGameMaster gameHasFinished).
]
