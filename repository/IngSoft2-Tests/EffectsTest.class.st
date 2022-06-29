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
	aBoard move: 'Razor Crest' to: 1 and: 1.
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
	aBoard move: 'Razor Crest' to: 1 and: 1.
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
	aBoard move: 'Razor Crest' to: 1 and: 3.
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
	aBoard move: 'Razor Crest' to: 0 and: 3.
	aBoard move: 'Millenium Falcon' to: 1 and: 3.
	aBoard move: 'SC30 StarFighter' to: 2 and: 3.
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
	aBoard move: 'Razor Crest' to: 0 and: 3.
	aBoard move: 'Millenium Falcon' to: 2 and: 2.
	aBoard move: 'SC30 StarFighter' to: 3 and: 3.
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
EffectsTest >> test06CardPickerSpotReturnsATypeOfCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot thirdSpot cardPicked |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: CardPicker new.
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
	aBoard move: 'Razor Crest' to: 0 and: 3.
	cardPicked := aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self assert: cardPicked assertThatIsACard
]

{ #category : #tests }
EffectsTest >> test07HyperJumpSpotIsTriggeredBySpaceshipAndMovesIt3Parsecs [

	| firstSpot secondSpot aDistance1 aDistance2 aDistance3 arrayOfJumps thirdSpot aCollectionOfSpots aCollectionOfSpaceships aBoard expectedPositionAfterFirstJump |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aDistance1 := Parsec distanceOf: 1.
	aDistance2 := Parsec distanceOf: 2.
	aDistance3 := Parsec distanceOf: 3.
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { 
			aDistance1.
			aDistance2.
			aDistance3 }.
	thirdSpot := Spot createWith: (Hyperjump createWith: arrayOfJumps).
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
	aBoard move: 'Razor Crest' to: 0 and: 3.
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
EffectsTest >> test08HyperJumpSpotIsCreatedWithParsecsAndLightyearsAndIsTriggeredBySpaceshipAndMovesIt [

	| firstSpot secondSpot aDistance1 aDistance2 aDistance3 arrayOfJumps thirdSpot aCollectionOfSpots aCollectionOfSpaceships aBoard expectedPositionAfterFirstJump expectedPositionAfterSecondJump |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aDistance1 := Parsec distanceOf: 1.
	aDistance2 := Parsec distanceOf: 3.
	aDistance3 := Lightyear distanceOf: 5.
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { 
			aDistance1.
			aDistance2.
			aDistance3 }.
	thirdSpot := Spot createWith: (Hyperjump createWith: arrayOfJumps).
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
	aBoard move: 'Razor Crest' to: 0 and: 3.
	expectedPositionAfterFirstJump := Position at: 1 on: 1.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPositionAfterFirstJump lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPositionAfterFirstJump spotNumber.
	aBoard move: 'Razor Crest' to: 1 and: 3.
	expectedPositionAfterSecondJump := Position at: 2 on: 1.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPositionAfterSecondJump spotNumber
]

{ #category : #tests }
EffectsTest >> test09HyperJumpSpotIsTriggeredBySpaceshipAndMovesIt9Lightyears [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot thirdSpot expectedPositionAfterFirstJump arrayOfJumps |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { 
			(Lightyear distanceOf: 9).
			(Parsec distanceOf: 2).
			(Parsec distanceOf: 1) }.
	thirdSpot := Spot createWith: (Hyperjump createWith: arrayOfJumps).
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
	aBoard move: 'Razor Crest' to: 0 and: 3.
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
EffectsTest >> test10HyperJumpMovesTriggeringSpaceshipTwiceOneExpresedInLightyearsAndTheSecondOneInParsecs [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots firstSpot secondSpot thirdSpot expectedPositionAfterFirstJump arrayOfJumps |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { 
			(Lightyear distanceOf: 10).
			(Parsec distanceOf: 3).
			(Parsec distanceOf: 1) }.
	thirdSpot := Spot createWith: (Hyperjump createWith: arrayOfJumps).
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
	aBoard move: 'Razor Crest' to: 0 and: 3.
	expectedPositionAfterFirstJump := Position at: 1 on: 1.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPositionAfterFirstJump lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPositionAfterFirstJump spotNumber.
	expectedPositionAfterFirstJump := Position at: 2 on: 1.
	aBoard move: 'Razor Crest' to: 1 and: 3.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPositionAfterFirstJump lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPositionAfterFirstJump spotNumber
]

{ #category : #tests }
EffectsTest >> test11IfJumpsDistanceIsSmallerThanParsecsPerSpotSpaceshipIsNotMoved [

	| firstSpot secondSpot aDistance1 aDistance2 aDistance3 arrayOfJumps thirdSpot aCollectionOfSpots aCollectionOfSpaceships aBoard expectedPositionAfterFirstJump expectedPositionAfterSecondJump |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aDistance1 := Parsec distanceOf: 1.
	aDistance2 := Parsec distanceOf: 2.
	aDistance3 := Parsec distanceOf: 3.
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { 
			aDistance1.
			aDistance2.
			aDistance3 }.
	thirdSpot := Spot createWith: (Hyperjump createWith: arrayOfJumps).
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 9
		          playedFor: 5
		          by: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' to: 0 and: 3.
	expectedPositionAfterFirstJump := Position at: 1 on: 1.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	aBoard move: 'Razor Crest' to: 1 and: 3.
	expectedPositionAfterSecondJump := Position at: 1 on: 3.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.

	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPositionAfterSecondJump lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPositionAfterSecondJump spotNumber
]

{ #category : #tests }
EffectsTest >> test12AfterUsedAllHyperJumpsStartsFromFirstOneAgain [

	| firstSpot secondSpot aDistance1 aDistance2 aDistance3 arrayOfJumps thirdSpot aCollectionOfSpots aCollectionOfSpaceships aBoard expectedPositionAfterFirstJump expectedPositionAfterSecondJump expectedPositionAfterThirdJump expectedPositionAfterFourthJump |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aDistance1 := Parsec distanceOf: 1.
	aDistance2 := Parsec distanceOf: 2.
	aDistance3 := Parsec distanceOf: 3.
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { 
			aDistance1.
			aDistance2.
			aDistance3 }.
	thirdSpot := Spot createWith: (Hyperjump createWith: arrayOfJumps).
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 9
		          playedFor: 5
		          by: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' to: 0 and: 3.
	expectedPositionAfterFirstJump := Position at: 1 on: 1.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	aBoard move: 'Razor Crest' to: 1 and: 3.
	expectedPositionAfterSecondJump := Position at: 1 on: 3.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.

	aBoard move: 'Razor Crest' to: 2 and: 3.
	expectedPositionAfterThirdJump := Position at: 2 on: 3.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.

	aBoard move: 'Razor Crest' to: 3 and: 3.
	expectedPositionAfterFourthJump := Position at: 4 on: 1.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPositionAfterFourthJump lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPositionAfterFourthJump spotNumber
]

{ #category : #tests }
EffectsTest >> test13IfJumpsDistanceHasDecimalPartItOnlyJumpsTheIntegerPart [

	| firstSpot secondSpot arrayOfJumps thirdSpot aCollectionOfSpots aCollectionOfSpaceships aBoard expectedPositionAfterFirstJump expectedPositionAfterSecondJump |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { 
			(Parsec distanceOf: 4).
			(Parsec distanceOf: 2).
			(Parsec distanceOf: 1) }.
	thirdSpot := Spot createWith: (Hyperjump createWith: arrayOfJumps).
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 5
		          by: aCollectionOfSpaceships.
	aBoard move: 'Razor Crest' to: 0 and: 3.
	expectedPositionAfterFirstJump := Position at: 1 on: 1.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.
	aBoard move: 'Razor Crest' to: 1 and: 3.
	expectedPositionAfterSecondJump := Position at: 1 on: 3.
	aBoard applyEffectTriggeredBy: 'Razor Crest'.

	self
		assert: (aBoard positionOf: 'Razor Crest') lapNumber
		equals: expectedPositionAfterSecondJump lapNumber.
	self
		assert: (aBoard positionOf: 'Razor Crest') spotNumber
		equals: expectedPositionAfterSecondJump spotNumber
]
