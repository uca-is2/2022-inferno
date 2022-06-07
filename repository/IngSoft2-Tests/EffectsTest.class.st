Class {
	#name : #EffectsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectsTest >> test01SpeedUpMovesCurrentPlayer4SpotsForwardFromFirstPosition [

	| testEffect gamePositions |
	gamePositions := GamePositions with: 2 around: 2.
	testEffect := SpeedUp new.
	testEffect applyTo: gamePositions limitedBy: 10.
	self assert: (gamePositions currentSpaceshipPosition ) equals: 5
]

{ #category : #tests }
EffectsTest >> test02WormholeMovesCurrentPlayer4SpotsBackFromFifthPosition [

	| testEffect gamePositions |
	gamePositions := GamePositions with: 2 around: 2.
	testEffect := Wormhole new.
	gamePositions moveCurrentTo: 5.
	testEffect applyTo: gamePositions limitedBy: 10.
	self assert: (gamePositions currentSpaceshipPosition ) equals: 1
]

{ #category : #tests }
EffectsTest >> test03AtomicBombMovesEverySpaceshipToSpotOne [
]
