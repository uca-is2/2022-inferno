Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ].

	self assert: errorWasRaised.
	self assert: errorMessage equals: expectedErrorMessage
]

{ #category : #test }
BoardTest >> testBoardReturnHowManySlotsItHasIsValid [
	| aBoard |
	aBoard := (Board with: 70).
	self assert: ((aBoard boardLength) isNumber ).
]

{ #category : #test }
BoardTest >> testCreateBoardWithAtLeastMinimunAmountOfSlotsIsValid [
	| aBoard |
	aBoard := (Board with: 7).
	self assert: (aBoard isValid: 4).
]

{ #category : #test }
BoardTest >> testCreateBoardWithAtLeastThreeSlotsIsValid [
	| aBoard |
	aBoard := (Board with: 7).
	self assert: (aBoard isValid).
]

{ #category : #test }
BoardTest >> testCreateBoardWithLessThanThreeSlotsIsInvalid [

	self
		should: [ Board  with: 1 ]
		raise: Error
		withMessage: 'Minimun length should be more than three'
]
