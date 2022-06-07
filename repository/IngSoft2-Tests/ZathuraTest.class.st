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
	| aDice aGame aBoard |
	aDice := Die with: 6.
	aBoard := Board with: 100 withALengthOf: 100.
	aGame := Zathura playedWith: aDice over: aBoard by: 2 around: 3.
	self assert: aGame isNotNil
]

{ #category : #tests }
ZathuraTest >> test03ZathuraGameCanBePlayedByIndividualTurnsUntilFinished [

	| aDie1 aDie2 aGame aCollection aDiceCup aBoard |
	aBoard := Board with: 100 withALengthOf: 100 .
	aDie1 := Die with: 6.
	aDie2 := Die with: 6.
	aCollection := Array new: 2.
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aDiceCup := DiceCup with: aCollection.
	aGame := Zathura playedWith: aDiceCup over: aBoard by: 3 around: 3.
	[ aGame hasGameFinished ] whileFalse: [ aGame playNextTurn ].
	self assert: aGame hasGameFinished

]

{ #category : #tests }
ZathuraTest >> test04ZathuraGameCanBePlayedUntilFinished [

	| aDie1 aDie2 aGame aCollection aDiceCup aBoard |
	aDie1 := Die with: 6.
	aBoard := Board with: 100 withALengthOf: 100 .
	aDie2 := Die with: 6.
	aCollection := Array new: 2.
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aDiceCup := DiceCup with: aCollection.
	aGame := Zathura playedWith: aDiceCup over: aBoard by: 3 around: 3.
	aGame playEntireGame.
	self assert: aGame hasGameFinished

]
