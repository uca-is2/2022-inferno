Class {
	#name : #TurnControllerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TurnControllerTest >> test01TurnControllerKeepsTrackOfTurns [

	| aTurnController spaceshipsPositions initialPosition |
	initialPosition := Position at: 0 on: 1.
	spaceshipsPositions := Dictionary new: 3.
	spaceshipsPositions at: 'SC30 StarFighter' put: initialPosition.
	spaceshipsPositions at: 'Razor Crest' put: initialPosition.
	spaceshipsPositions at: 'Millenium Falcon' put: initialPosition.
	aTurnController := TurnController with: spaceshipsPositions.
	self
		assert: aTurnController activeSpaceship
		equals: 'SC30 StarFighter'
]

{ #category : #tests }
TurnControllerTest >> test02CanChangeActiveSpaceshipToTheNextOne [

	| aTurnController spaceshipsPositions initialPosition |
	initialPosition := Position at: 0 on: 1.
	spaceshipsPositions := Dictionary new: 3.
	spaceshipsPositions at: 'SC30 StarFighter' put: initialPosition.
	spaceshipsPositions at: 'Razor Crest' put: initialPosition.
	spaceshipsPositions at: 'Millenium Falcon' put: initialPosition.
	aTurnController := TurnController with: spaceshipsPositions.
	aTurnController nextSpaceshipInLine.
	self assert: aTurnController activeSpaceship equals: 'Razor Crest'
]

{ #category : #tests }
TurnControllerTest >> test03CanChangeToFirstSpacehipWhenReachedTheLastOne [

	| aTurnController spaceshipsPositions initialPosition |
	initialPosition := Position at: 0 on: 1.
	spaceshipsPositions := Dictionary new: 3.
	spaceshipsPositions at: 'SC30 StarFighter' put: initialPosition.
	spaceshipsPositions at: 'Razor Crest' put: initialPosition.
	spaceshipsPositions at: 'Millenium Falcon' put: initialPosition.
	aTurnController := TurnController with: spaceshipsPositions.
	aTurnController nextSpaceshipInLine.
	aTurnController nextSpaceshipInLine.
	aTurnController nextSpaceshipInLine.
	self
		assert: aTurnController activeSpaceship
		equals: 'SC30 StarFighter'
]
