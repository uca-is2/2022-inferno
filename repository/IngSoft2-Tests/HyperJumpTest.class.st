Class {
	#name : #HyperJumpTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
HyperJumpTest >> test01HyperJumpSpotCanBecreatedAndSpaceshipMovesCorrectPositions [

	| firstSpot secondSpot aDistance1 aDistance2 aDistance3 arrayOfJumps thirdSpot |
	firstSpot:= Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	aDistance1:= Parsecs with: 1.
	aDistance2:= Parsecs with: 2.
	aDistance3:= Parsecs with: 3.
	arrayOfJumps:= OrderedCollection new:3.
	arrayOfJumps addAllFirst: { aDistance1. aDistance2. aDistance3. }.
	thirdSpot := Spot createWith:
		             (HyperJump2  createWith: arrayOfJumps).
		
]
