Class {
	#name : #EffectsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectsTest >> test01NoEffectDoesNothingToAnySpaceship [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot thirdSpot expectedPosition |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          withALengthOf: 10
		          around: 3
		          playedBy: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 1 andSpot: 1.
	expectedPosition := Position atLap: 1 andSpot: 1.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPosition lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPosition spotNumber
]

{ #category : #tests }
EffectsTest >> test02SpeedUpMovesSpaceship4SpotsForward [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot thirdSpot expectedPosition |
	firstSpot := Spot createWith: SpeedUp new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          withALengthOf: 10
		          around: 3
		          playedBy: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 1 andSpot: 1.
	expectedPosition := Position atLap: 2 andSpot: 2.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPosition lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPosition spotNumber
]

{ #category : #tests }
EffectsTest >> test03WormholeMovesSpaceship4SpotsBackwards [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot thirdSpot expectedPosition |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: Wormhole new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          withALengthOf: 10
		          around: 2
		          playedBy: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 1 andSpot: 3.
	expectedPosition := Position atLap: 0 andSpot: 2.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPosition lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPosition spotNumber
]

{ #category : #tests }
EffectsTest >> test04AtomicBombPutsEverySpaceshipInSpotZeroAndCurrentLap [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot thirdSpot expectedPositionOne expectedPositionTwo expectedPositionThree |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: AtomicBomb new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          withALengthOf: 10
		          around: 3
		          playedBy: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 0 andSpot: 3.
	aBoard move: 'Millenium Falcon' toLap: 1 andSpot: 3.
	aBoard move: 'SC30 StarFighter' toLap: 2 andSpot: 3.
	expectedPositionOne := Position atLap: 0 andSpot: 1.
	expectedPositionTwo := Position atLap: 1 andSpot: 1.
	expectedPositionThree := Position atLap: 2 andSpot: 1.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPositionOne lapNumber.
	self assert: (aBoard positionOf: 'Razor Crest') spotNumber equals: 1.
	self
		assert: (aBoard positionOf: 'Millenium Falcon') lapNumber
		equals: expectedPositionTwo lapNumber.
	self
		assert: (aBoard positionOf: 'Millenium Falcon') spotNumber
		equals: 1.
	self
		assert: (aBoard positionOf: 'SC30 StarFighter') lapNumber
		equals: expectedPositionThree lapNumber.
	self
		assert: (aBoard positionOf: 'SC30 StarFighter') spotNumber
		equals: 1
]

{ #category : #tests }
EffectsTest >> test05MoonwalkMovesEveryOtherSpaceshipNSpotsBackwards [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot thirdSpot expectedPositionOne expectedPositionTwo expectedPositionThree |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: (Moonwalk createWith: 10).
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          withALengthOf: 10
		          around: 3
		          playedBy: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 0 andSpot: 3.
	aBoard move: 'Millenium Falcon' toLap: 2 andSpot: 2.
	aBoard move: 'SC30 StarFighter' toLap: 3 andSpot: 3.
	expectedPositionOne := Position atLap: 0 andSpot: 3.
	expectedPositionTwo := Position atLap: 0 andSpot: 1.
	expectedPositionThree := Position atLap: 0 andSpot: 2.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPositionOne lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPositionOne spotNumber.
	self
		assert: (aBoard positionOf: 'Millenium Falcon') lapNumber
		equals: expectedPositionTwo lapNumber.
	self
		assert: (aBoard positionOf: 'Millenium Falcon') spotNumber
		equals: expectedPositionTwo spotNumber.
	self
		assert: (aBoard positionOf: 'SC30 StarFighter') lapNumber
		equals: expectedPositionThree lapNumber.
	self
		assert: (aBoard positionOf: 'SC30 StarFighter') spotNumber
		equals: expectedPositionThree spotNumber
]

{ #category : #tests }
EffectsTest >> test06HyperJumpMovesTriggeringSpaceshipTheAmountOfParsecsGiven [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot thirdSpot expectedPositionAfterFirstJump arrayOfJumps |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { 1. 2. 3 }.
	thirdSpot := Spot createWith:
		             (Hyperjump
			              createWith: arrayOfJumps
			              measuredIn: 'parsecs').
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          withALengthOf: 9
		          around: 3
		          playedBy: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 0 andSpot: 3.
	expectedPositionAfterFirstJump := Position atLap: 1 andSpot: 1.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPositionAfterFirstJump lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPositionAfterFirstJump spotNumber
]
