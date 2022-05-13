Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	|errorWasRaised errorMessage|
	errorBlock
	on: errorClass 
	do: [ :error |
		errorWasRaised := true.
		errorMessage := error messageText ].
]

{ #category : #tests }
GameTest >> testAGameCanBeCreated [

	| aDice aBoard aGame |
	aDice := Die with: 6.
	aBoard := Board with: 70.
	aGame := Game
		         withDice: aDice
		         withBoard: aBoard
		         andAmountOfLaps: nil
		         withAmountOfSpaceships: 2.
	self assert: aGame isNotNil
]

{ #category : #tests }
GameTest >> testAGameCanBePlayedByIndividualTurns [

	| aDie1 aDie2 aBoard aGame aCollection aDiceCup |
	aDie1 := Die with: 6.
	aDie2 := Die with: 6.
	aCollection := Array new: 2.
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aDiceCup := DiceCup with: aCollection.
	aBoard := Board with: 50.
	aGame := Game
		         withDice: aDiceCup
		         withBoard: aBoard
		         andAmountOfLaps: 2
		         withAmountOfSpaceships: 3.
	[ aGame hasGameFinished ] whileFalse: [ aGame playNextTurn ].
	self assert: aGame hasGameFinished
]

{ #category : #tests }
GameTest >> testAGameCanBeStartedAndPlayedToTheEnd [

	| aDie1 aDie2 aDie3 aBoard aGame aCollection aDiceCup |
	aDie1 := Die with: 6.
	aDie2 := Die with: 4.
	aDie3 := Die with: 6.
	aCollection := Array new: 3.
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aCollection at: 3 put: aDie3.
	aDiceCup := DiceCup with: aCollection.
	aBoard := Board with: 50.
	aGame := Game
		         withDice: aDiceCup
		         withBoard: aBoard
		         andAmountOfLaps: 2
		         withAmountOfSpaceships: 5.
	aGame playEntireGame.
	self assert: aGame hasGameFinished
]

{ #category : #tests }
GameTest >> testAGameCannotBeCreatedWithoutBoard [

	| aGame error errorMessage aDie |
	aDie := Die with: 9.
	aGame := [ 
	         Game
		         withDice: aDie
		         withBoard: nil
		         andAmountOfLaps: nil
		         withAmountOfSpaceships: 2 ].
	error := Error.
	errorMessage := 'A game cannot be created without a board.'.
	self should: aGame raise: error withMessage: errorMessage
]

{ #category : #tests }
GameTest >> testAGameCannotBeCreatedWithoutDice [

	| aBoard aGame error errorMessage |
	aBoard := [ Board with: 70 ].
	aGame := [ 
	         Game
		         withDice: nil
		         withBoard: aBoard
		         andAmountOfLaps: nil
		         withAmountOfSpaceships: 2 ].
	error := Error.
	errorMessage := 'A game cannot be created without dice.'.
	self should: aGame raise: error withMessage: errorMessage
]

{ #category : #tests }
GameTest >> testAGameCannotBeCreatedWithoutSpaceShips [

	| aGame error errorMessage aDie aBoard |
	aDie := Die with: 9.
	aBoard := [ Board with: 70 ].
	aGame := [ 
	         Game
		         withDice: aDie
		         withBoard: aBoard
		         andAmountOfLaps: nil
		         withAmountOfSpaceships: 1 ].
	error := Error.
	errorMessage := 'A game cannot be created with a number of spaceships lower than two.'.
	self should: aGame raise: error withMessage: errorMessage
]
