Class {
	#name : #BoardCreatorTest,
	#superclass : #TestCase,
	#category : #'Zathura-Tests'
}

{ #category : #asserting }
BoardCreatorTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

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
BoardCreatorTest >> testCreateBoardWithAtLeastMinimunAmountOfSlotsIsValid [
	| aBoard |
	aBoard := (Board with: 7).
	self assert: (aBoard isValid: 4).
]

{ #category : #test }
BoardCreatorTest >> testCreateBoardWithAtLeastThreeSlotsIsValid [
	| aBoard |
	aBoard := (Board with: 7).
	self assert: (aBoard isValid).
]

{ #category : #test }
BoardCreatorTest >> testCreateBoardWithLessThanThreeSlotsIsInvalid [

	self
		should: [ Board  with: 1 ]
		raise: Error
		withMessage: 'Minimun length should be more than three'
]
