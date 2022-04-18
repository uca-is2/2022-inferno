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
		errorWasRaised:= true.
		errorMessage := error messageText ].
]

{ #category : #tests }
DieTest >> test01DieNumberOfSidesCannotBeLowerThanThree [ 
	|aDie|
	aDie := RandomDie with: 3.
		
	self assert: (aDie isValid)
]

{ #category : #'tests-randomDice' }
DieTest >> test02RandomDieCannotBeCreatedWithNumberOfSidesLowerThanThree [
	| aRandomDie error errorMessage |
	aRandomDie := [ RandomDie with: 2].
	error := Error.
	errorMessage := 'Die cant be created with a number of sides lower than 3'.
	self should: aRandomDie raise: error withMessage: errorMessage
]

{ #category : #'tests-randomDice' }
DieTest >> test03RandomDieIsThrownAndReturnsANumberBetweenOneAndNumberOfSides [

	|aRandomDie aResult aNumberOfSides|
	aNumberOfSides := 6.
	aRandomDie := RandomDie with: aNumberOfSides.
	aResult := aRandomDie roll.
	
	self assert: (aResult between: 1 and: aNumberOfSides)
]

{ #category : #'tests-randomDice' }
DieTest >> test04RandomDieDoesReturnANumber [
	| aRandomDie |
	aRandomDie := RandomDie with: 6.
	
	self assert: aRandomDie roll isInteger
]

{ #category : #'tests-randomDice' }
DieTest >> test05RandomDieCannotReturnZeroOrLower [

	|aRandomDie aResult|
	aRandomDie := RandomDie with: 6.
	aResult := aRandomDie roll.
	
	self deny: aResult < 0
]

{ #category : #'tests-LoadedDice' }
DieTest >> test06LoadedDieRollResultIsLoadedSideNumber [
	|aLoadedDie aResult |
	aLoadedDie := LoadedDie with: 5.
	aResult := aLoadedDie roll.
	self assert: aResult equals: 5.
]

{ #category : #'tests-LoadedDice' }
DieTest >> test07LoadedDieCannotBeLoadedWithInvalidNumber [

	self 
		should: [ LoadedDie with: -1 ]
		raise: Error 
		withMessage: 'Minimum lenght should be more than three.'
]
