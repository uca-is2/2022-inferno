Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	|errorWasRaised errorMessage|
	errorBlock
	on: errorClass 
	do: [ :error |
		errorWasRaised := true.
		errorMessage := error messageText ].
]

{ #category : #asserting }
BoardTest >> testABoardHasMoreThanOneSlotAndNinePaesecsIsValid [

	| aBoard |
	aBoard := Board with: 1 andNumberOfParsecs: 10.
	self assert: aBoard isValid
]

{ #category : #asserting }
BoardTest >> testCannotCreateABoardWithInvalidNumberOfSlots [

	| aBoard error errorMessage |
	aBoard := [ Board with: -5 andNumberOfParsecs: 100].
	error := Error.
	errorMessage := 'Board cannot be created with a number of slots lower than 1 or Parsecs lower than 9'.
	self should: aBoard raise: error withMessage: errorMessage
]

{ #category : #asserting }
BoardTest >> testCannotCreateABoardWithLessThan9Parsecs [

	| aBoard error errorMessage |
	aBoard := [ Board with: 6 andNumberOfParsecs: 1].
	error := Error.
	errorMessage := 'Board cannot be created with a number of slots lower than 1 or Parsecs lower than 9'.
	self should: aBoard raise: error withMessage: errorMessage
]

{ #category : #asserting }
BoardTest >> testInitializingABoardCreatesTheBoardWithEffects [

	| aBoard |
	aBoard := Board with: 100 andNumberOfParsecs: 7343.
	
	self assert:( aBoard layout isKindOf: Dictionary)
]

{ #category : #asserting }
BoardTest >> testPercentageOfSlotsPerEffectsInBoardIsValid [
	| aBoard amountOfSpeedups amountOfWormholes amountOfMoonWalks amountOfHyperJumps amountOfAtomicBombs numberOfSlots |
	aBoard := Board with: 100 andNumberOfParsecs: 7343.
	amountOfSpeedups := (aBoard layout at: 'speedUps') size.
	amountOfWormholes := (aBoard layout at: 'wormholes') size.
	amountOfMoonWalks := (aBoard layout at: 'moonWalks' at: 1) size.
	amountOfHyperJumps := (aBoard layout at: 'hyperJumps') size.
	amountOfAtomicBombs := (aBoard layout at: 'atomicBombs') size.
	
	numberOfSlots := aBoard lenght. 
	self assert:( (amountOfSpeedups = (numberOfSlots * 0.2)asInteger) & (amountOfWormholes = (numberOfSlots * 0.2)asInteger) & (amountOfMoonWalks = (numberOfSlots * 0.1)asInteger) & (amountOfHyperJumps = (numberOfSlots * 0.08)asInteger) & (amountOfAtomicBombs = (numberOfSlots * 0.02)asInteger))
]
