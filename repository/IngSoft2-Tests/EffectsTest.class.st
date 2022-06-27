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
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 1 andSpot: 1.
	expectedPosition := Position at: 1 on: 1.
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
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 1 andSpot: 1.
	expectedPosition := Position at: 2 on: 2.
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
		          and: 10
		          playedFor: 2
		          by: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 1 andSpot: 3.
	expectedPosition := Position at: 0 on: 2.
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
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 0 andSpot: 3.
	aBoard move: 'Millenium Falcon' toLap: 1 andSpot: 3.
	aBoard move: 'SC30 StarFighter' toLap: 2 andSpot: 3.
	expectedPositionOne := Position at: 0 on: 1.
	expectedPositionTwo := Position at: 1 on: 1.
	expectedPositionThree := Position at: 2 on: 1.
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
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 0 andSpot: 3.
	aBoard move: 'Millenium Falcon' toLap: 2 andSpot: 2.
	aBoard move: 'SC30 StarFighter' toLap: 3 andSpot: 3.
	expectedPositionOne := Position at: 0 on: 3.
	expectedPositionTwo := Position at: 0 on: 1.
	expectedPositionThree := Position at: 0 on: 2.
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
		          and: 9
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 0 andSpot: 3.
	expectedPositionAfterFirstJump := Position at: 1 on: 1.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPositionAfterFirstJump lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPositionAfterFirstJump spotNumber
]

{ #category : #tests }
EffectsTest >> test07CardPickerSpotReturnsATypeOfCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot thirdSpot cardPicked|
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: CardPicker new.
	aCollectionOfSpots := { firstSpot . secondSpot . thirdSpot  }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 9
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' toLap: 0 andSpot: 3.
	cardPicked := aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self assert: cardPicked assertThatIsACard.
	
]
