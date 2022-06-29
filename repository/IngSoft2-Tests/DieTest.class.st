Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ]
]

{ #category : #testsDie }
DieTest >> test01ADieHasMoreThanTwoSides [

	| aDie |
	aDie := Die with: 3.
	self assert: aDie isValid
]

{ #category : #testsDie }
DieTest >> test02ADieCannotHaveANegativeSide [

	| aDie error errorMessage |
	aDie := [ Die with: -5 ].
	error := Error.
	errorMessage := 'Die cannot be created with a number of sides lower than 3'.
	self should: aDie raise: error withMessage: errorMessage
]

{ #category : #testsDie }
DieTest >> test03DieRollDoesReturnAnInteger [

	| aDie |
	aDie := Die with: 6.
	self assert: aDie roll isInteger
]

{ #category : #testsDie }
DieTest >> test04DieIsRolledAndReturnsANumberBetweenOneAndNumberOfSides [

	| aNumberOfSides aDie aResult |
	aNumberOfSides := 7.
	aDie := Die with: aNumberOfSides.
	aResult := aDie roll.
	self assert: (aResult between: 1 and: aNumberOfSides)
]

{ #category : #testsLoadedDie }
DieTest >> test05ALoadedDieHasALoadedSideAndDieIsValid [

	| aDie |
	aDie := LoadedDie with: 3.
	self assert: aDie isValid
]

{ #category : #testsLoadedDie }
DieTest >> test06ALoadedDieIsRolledAndReturnsLoadedSide [

	| aLoadedSide aDie |
	aLoadedSide := 3.
	aDie := LoadedDie with: aLoadedSide.
	self assert: aDie roll equals: aLoadedSide
]
