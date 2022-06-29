Class {
	#name : #HyperJumpTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
HyperJumpTest >> test01HyperJumpSpotCanBecreatedAndSpaceshipMovesCorrectPositions [

	| firstSpot secondSpot aDistance1 aDistance2 aDistance3 arrayOfJumps thirdSpot aCollectionOfSpots aCollectionOfSpaceships aBoard expectedPositionAfterFirstJump |
	firstSpot:= Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aDistance1:= Parsecs with: 1.
	aDistance2:= Parsecs with: 2.
	aDistance3:= Parsecs with: 3.
	arrayOfJumps:= OrderedCollection new:3.
	arrayOfJumps addAllFirst: { aDistance1. aDistance2. aDistance3. }.
	thirdSpot := Spot createWith:
		             (HyperJump2  createWith: arrayOfJumps).
	aCollectionOfSpots := { 
		firstSpot.
		secondSpot.
		thirdSpot.
	 }.
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
