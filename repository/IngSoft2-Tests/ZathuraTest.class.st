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

{ #category : #tests }
ZathuraTest >> test04ZathuraGameCanBePlayedByIndividualTurnsUntilFinished [

	| aDie1 aDie2 aBoard aGame aCollection aDiceCup |
	aDie1 := Die with: 6.
	aDie2 := Die with: 6.
	aCollection := Array new: 2.
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aDiceCup := DiceCup with: aCollection.
	aBoard := Board with: 50 withALenghtOf: 300.
	aGame := Zathura playedWith: aDiceCup over: aBoard around: 2 by: 3.
	[ aGame hasGameFinished ] whileFalse: [ aGame playNextTurn ].
	self assert: aGame hasGameFinished

]

{ #category : #tests }
ZathuraTest >> test05ZathuraGameCanBePlayedUntilFinished [

	| aDie1 aDie2 aBoard aGame aCollection aDiceCup |
	aDie1 := Die with: 6.
	aDie2 := Die with: 6.
	aCollection := Array new: 2.
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aDiceCup := DiceCup with: aCollection.
	aBoard := Board with: 50 withALenghtOf: 300.
	aGame := Zathura playedWith: aDiceCup over: aBoard around: 2 by: 3.
	aGame playEntireGame.
	self assert: aGame hasGameFinished

]
