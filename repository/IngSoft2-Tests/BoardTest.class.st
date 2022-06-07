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

{ #category : #tests }
BoardTest >> test01BoardCannotBeCreatedWithANumberOfSpotsLowerThanOne [

	| aBoard error errorMessage |
	aBoard := [ Board with: -6 withALengthOf: 1].
	error := Error.
	errorMessage := 'Board cannot be created with a number of spots lower than one'.
	self should: aBoard raise: error withMessage: errorMessage
	

]

{ #category : #tests }
BoardTest >> test02BoardCannotBeCreatedWithALenghtInParsecsLowerThanTheAmountOfSpots [

	| aBoard error errorMessage |
	aBoard := [ Board with: -6 withALengthOf: 1].
	error := Error.
	errorMessage := 'Board cannot be created with a number of parsecs lower than the amount of spots'.
	self should: aBoard raise: error withMessage: errorMessage
	

]

{ #category : #tests }
BoardTest >> test03ABoardCanReturnItsLenghtInParsecs [

	| aBoard anAmountOfParsecs |
	anAmountOfParsecs := 100.
	aBoard := Board with: 100 withALengthOf: 100  .
	self assert: aBoard lenghtInParsecs equals: anAmountOfParsecs. 
	

]

{ #category : #tests }
BoardTest >> test04CreatedBoardHasALayoutThatIsAnArrayOfSpots [

	| aBoard |
	aBoard := Board with: 100 withALengthOf:100 .
	self assert: (aBoard layout isKindOf: Array).
	

]

{ #category : #tests }
BoardTest >> test05ABoardCanReturnItsLenghtInSpots [

	| aBoard aNumberOfSpots |
	aNumberOfSpots := 10.
	aBoard := Board with: aNumberOfSpots withALengthOf: 100.
	self assert: aBoard length equals: aNumberOfSpots.
	
	

]

{ #category : #tests }
BoardTest >> test06ABoardIsCreatedAndEffectsAredDistributed [

	| aBoard |
	aBoard := Board with: 10 withALengthOf: 100.
	self assert: ((((aBoard layout) at:5)effectAtSpot) isKindOf: Effect).
	

]

{ #category : #tests }
BoardTest >> test07ABoardIsCreatedAndAllElementsOfArrayAreSpots [

	| aBoard flag |
	flag := true.
	aBoard := Board with: 100 withALengthOf: 1000 . 
	1 to: 100 do:  [ :each| (((aBoard layout) at: each) isKindOf: Spot)ifFalse: [ flag := false 
			]
		].
	self assert: (flag).
	

]
