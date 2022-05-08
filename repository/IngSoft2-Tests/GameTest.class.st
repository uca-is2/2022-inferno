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
		         withAmountOfSpaceships: 2.
	self assert: aGame isNotNil 
]

{ #category : #tests }
GameTest >> testAGameCannotBeCreatedWithoutDice [

	| aBoard aGame error errorMessage |
	aBoard := [ Board with: 70 ].
	aGame := [ 
	         Game
		         withDice: nil
		         withBoard: aBoard
		         withAmountOfSpaceships: 2 ].
	error := Error.
	errorMessage := 'A game cannot be created without dice.'.
	self should: aGame raise: error withMessage: errorMessage
]
