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
BoardTest >> testABoardHasMoreThanOneSlot [

	| aBoard |
	aBoard := Board with: 1.
	self assert: aBoard isValid
]

{ #category : #tests }
BoardTest >> testBoardLenghtReturnsNumberOfSlots [

	| aBoard |
	aBoard := Board with: 700.
	self assert: aBoard lenght equals: 700
]

{ #category : #asserting }
BoardTest >> testCannotCreateABoardWithInvalidNumberOfSlots [

	| aBoard error errorMessage |
	aBoard := [ Board with: -5 ].
	error := Error.
	errorMessage := 'Board cannot be created with a number of slots lower than one'.
	self should: aBoard raise: error withMessage: errorMessage
]
