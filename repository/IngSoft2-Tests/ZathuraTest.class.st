Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
ZathuraTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	|errorWasRaised errorMessage|
	errorBlock
	on: errorClass 
	do: [ :error |
		errorWasRaised := true.
		errorMessage := error messageText ].
]

{ #category : #tests }
ZathuraTest >> test01ZathuraGameCanBeStarted [
	| aDice aBoard aGame |
	aDice := Die with: 6.
	aBoard := Board with: 100 withALenghtOf: 1000.
	aGame := Zathura playedWith: aDice over: aBoard around: 3 by: 2.
	self assert: aGame isNotNil
]

{ #category : #tests }
ZathuraTest >> test02AGameCannotBeCreatedWithNegativeNumberOfLaps [

	| aDice aBoard aGame error errorMessage |
	error := Error.
	errorMessage := 'A game cannot be created without a valid amount of laps.'.
	aDice := Die with: 6.
	aBoard := Board with: 100 withALenghtOf: 1000.
	aGame := [Zathura playedWith: aDice over: aBoard around: -1 by: 2.].
	self should: aGame raise: error withMessage: errorMessage



]

{ #category : #tests }
ZathuraTest >> test03ZathuraGameCannotBeCreatedWithANumberOfSpaceshipsLowerThanTwo [

	| aDice aBoard aGame error errorMessage |
	error := Error.
	errorMessage := 'A game cannot be created with a number of spaceships lower than two.'.
	aDice := Die with: 6.
	aBoard := Board with: 100 withALenghtOf: 1000.
	aGame := [Zathura playedWith: aDice over: aBoard around: -1 by: 2.].
	self should: aGame raise: error withMessage: errorMessage


]
