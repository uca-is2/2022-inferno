Class {
	#name : #GamePositionsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GamePositionsTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	|errorWasRaised errorMessage|
	errorBlock
	on: errorClass 
	do: [ :error |
		errorWasRaised := true.
		errorMessage := error messageText ].
]

{ #category : #tests }
GamePositionsTest >> test01GamePositionsInstanceCanBeCreated [

	| spaceshipsPositions |
	spaceshipsPositions := GamePositions with: 2.
	self assert: spaceshipsPositions isNotNil.
]

{ #category : #tests }
GamePositionsTest >> test02GamePositionsInstanceCannotBeCreatedWithLessThanTwoSpaceships [

	| spaceshipsPositions error errorMessage |
	error := Error.
	errorMessage := 'GamePositions cannot be created with a number of spaceships lower than 2'.
	spaceshipsPositions := [GamePositions with: 1].
	self should: spaceshipsPositions raise: error withMessage: errorMessage
]

{ #category : #tests }
GamePositionsTest >> test03GamePositionsInstanceCanReturnCurrentSpaceship [

	| spaceshipsPositions curr |
	
	spaceshipsPositions := GamePositions with: 4.
	curr := spaceshipsPositions currentSpaceshipId.
	self assert: curr equals: 1.
]

{ #category : #tests }
GamePositionsTest >> test04GamePositionsCurrentSpaceshipIdCanBeMovedOntoTheNextSpaceship [

	| spaceshipsPositions |
	
	spaceshipsPositions := GamePositions with: 4.
	spaceshipsPositions nextSpaceshipInLine.
	self assert: spaceshipsPositions currentSpaceshipId equals: 2.
]

{ #category : #tests }
GamePositionsTest >> test05GamePositionsCurrentSpaceshipIdMovesOntoFirstSpaceshipIfItIsTheLast [

	| spaceshipsPositions |
	
	spaceshipsPositions := GamePositions with: 3.
	spaceshipsPositions nextSpaceshipInLine.
	spaceshipsPositions nextSpaceshipInLine.
	spaceshipsPositions nextSpaceshipInLine.
	self assert: spaceshipsPositions currentSpaceshipId equals: 1.
]

{ #category : #tests }
GamePositionsTest >> test05GamePositionsReturnsCurrentSpaceshipPosition [

	| spaceshipsPositions testPos |
	
	spaceshipsPositions := GamePositions with: 3.
	spaceshipsPositions nextSpaceshipInLine.
	testPos := spaceshipsPositions currentSpaceshipPosition .
	self assert: testPos equals: 1.
]

{ #category : #tests }
GamePositionsTest >> test06GamePositionsReturnsCurrentSpaceshipLap [

	| spaceshipsPositions testLap |
	
	spaceshipsPositions := GamePositions with: 3.
	spaceshipsPositions nextSpaceshipInLine.
	testLap := spaceshipsPositions currentSpaceshipLap.
	self assert: testLap equals: 0.
]

{ #category : #tests }
GamePositionsTest >> test07GamePositionInstanceCanMoveCurrentSpaceship [
	
	| spaceshipsPositions testPos |
	
	spaceshipsPositions := GamePositions with: 3.
	spaceshipsPositions nextSpaceshipInLine.
	spaceshipsPositions moveCurrentTo: 3.
	testPos := spaceshipsPositions currentSpaceshipPosition .
	self assert: testPos equals: 3.
]

{ #category : #tests }
GamePositionsTest >> test08GamePositionInstanceCanMoveCurrentSpaceshipWithLap [
	
	| spaceshipsPositions testLap |
	
	spaceshipsPositions := GamePositions with: 3.
	spaceshipsPositions nextSpaceshipInLine.
	spaceshipsPositions moveCurrentTo: 3 andLap: 2.
	testLap := spaceshipsPositions currentSpaceshipLap  .
	self assert: testLap equals: 2.
]
