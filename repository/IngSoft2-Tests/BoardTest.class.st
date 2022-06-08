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
BoardTest >> test01ABoardHasAtLeastOneSpot [
	| aBoard aCollectionOfSpaceships aCollectionOfSpots  firstSpot |
	firstSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { firstSpot. }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALenghtOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	self assert: aBoard isValid.
]

{ #category : #tests }
BoardTest >> test02ABoardCanMoveASpaceshipToDesiredPosition [
	| aBoard aCollectionOfSpaceships aCollectionOfSpots  firstSpot secondSpot |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { firstSpot. secondSpot.}.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALenghtOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	aBoard move: 'SC30 StarFighter' toLap: 2 andSpot: 2.
	self assert: (aBoard positionOf: 'SC30 StarFighter') lapNumber equals: 2 .
	self assert: (aBoard positionOf: 'SC30 StarFighter') spotNumber equals: 2.
]

{ #category : #tests }
BoardTest >> test03ABoardCannotMoveASpaceshipToInvalidLap [
	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot error errorMessage invalidMove |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	error := Error.
	errorMessage := 'Cannot move a spaceship to invalid lap.'.
	aCollectionOfSpots := { firstSpot. secondSpot.}.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALenghtOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	invalidMove := [aBoard move: 'SC30 StarFighter' toLap: 2 andSpot: 3].
	self should: invalidMove raise: error withMessage: errorMessage. 
]

{ #category : #tests }
BoardTest >> test04ABoardCannotMoveASpaceshipToInvalidPosition [
	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot error errorMessage invalidMove |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	error := Error.
	errorMessage := 'Cannot move a spaceship to an invalid position.'.
	aCollectionOfSpots := { firstSpot. secondSpot.}.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALenghtOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	invalidMove := [aBoard move: 'SC30 StarFighter' toLap: 1 andSpot: -1].
	self should: invalidMove raise: error withMessage: errorMessage. 
]
