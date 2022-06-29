Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ]
]

{ #category : #tests }
BoardTest >> test01ABoardHasAtLeastOneSpot [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot |
	firstSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { firstSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	self assert: aBoard lengthInSpots equals: 1.
]

{ #category : #tests }
BoardTest >> test02ABoardCanMoveASpaceshipToDesiredPosition [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aBoard move: 'SC30 StarFighter' to: 2 and: 2.
	self
		assert: (aBoard positionOf: 'SC30 StarFighter') lapNumber
		equals: 2.
	self
		assert: (aBoard positionOf: 'SC30 StarFighter') spotNumber
		equals: 2
]

{ #category : #tests }
BoardTest >> test03ABoardCannotMoveASpaceshipToInvalidLap [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot error errorMessage invalidMove |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	error := Error.
	errorMessage := 'Cannot move a spaceship to invalid lap.'.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	invalidMove := [ aBoard move: 'SC30 StarFighter' to: 2 and: 3 ].
	self should: invalidMove raise: error withMessage: errorMessage
]

{ #category : #tests }
BoardTest >> test04ABoardCannotMoveASpaceshipToInvalidPosition [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot error errorMessage invalidMove |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	error := Error.
	errorMessage := 'Cannot move a spaceship to an invalid position.'.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	invalidMove := [ 
	               aBoard move: 'SC30 StarFighter' to: 1 and: -1 ].
	self should: invalidMove raise: error withMessage: errorMessage
]

{ #category : #tests }
BoardTest >> test05ABoardCanReturnItsLenghtInSpots [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aBoard move: 'SC30 StarFighter' to: 2 and: 2.
	self assert: aBoard lengthInSpots equals: 2
]

{ #category : #tests }
BoardTest >> test06ABoardCanReturnItsLenghtInParsecs [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aBoard move: 'SC30 StarFighter' to: 2 and: 2.
	self assert: aBoard lengthInParsecs equals: 10
]

{ #category : #tests }
BoardTest >> test07ABoardCanReturnItsAmountOfLapsToBePlayed [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aBoard move: 'SC30 StarFighter' to: 2 and: 2.
	self assert: aBoard amountOfLaps equals: 3
]

{ #category : #tests }
BoardTest >> test08ABoardCanReturnThePositionOfAllTheSpaceships [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aBoard move: 'SC30 StarFighter' to: 2 and: 2.
	self
		assert: (aBoard spaceshipPositions at: 'SC30 StarFighter') lapNumber
		equals: 2
]
