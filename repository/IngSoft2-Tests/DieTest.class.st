Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	|errorWasRaised errorMessage|
	errorBlock
	on: errorClass 
	do: [ :error |
		errorWasRaised := true.
		errorMessage := error messageText ].
]

{ #category : #testsDie }
DieTest >> testADieCannotHaveANegativeSide [
	
	| aDie error errorMessage|
	aDie := [Die with: -5].
	error:=Error.
	errorMessage := 'Die cannot be created with a number of sides lower than 3'.
	self should: aDie raise: error withMessage: errorMessage.
]

{ #category : #testsDie }
DieTest >> testADieHasMoreThanTwoSides [
	
	| aDie |
	aDie := Die with: 3.
	self assert: (aDie isValid).
]

{ #category : #testsLoadedDie }
DieTest >> testALoadedDieHasALoadedSideAndDieIsValid [

	| aDie |
	aDie:= LoadedDie with: 5 loadedWith:3.
	self assert: aDie isValid.
]

{ #category : #testsLoadedDie }
DieTest >> testALoadedDieIsRolledAndReturnsLoadedSide [
	
	| aLoadedSide aDie |
	aLoadedSide:=3.
	aDie:= LoadedDie with: 6 loadedWith: aLoadedSide.
	self assert: aDie roll equals: aLoadedSide.
]

{ #category : #testsDie }
DieTest >> testDieIsRolledAndReturnsANumberBetweenOneAndNumberOfSides [
	| aNumberOfSides aDie aResult |
	aNumberOfSides:=7.
	aDie:= Die with: aNumberOfSides.
	aResult:= aDie roll.
	self assert: (aResult between: 1 and: aNumberOfSides).
]

{ #category : #testsDie }
DieTest >> testDieRollDoesReturnAnInteger [
	|aDie|
	aDie:= Die with: 6.
	self assert: (aDie roll isInteger).
]
