"
i represent the positioning of spaceships in a game of zathura
"
Class {
	#name : #GamePositions,
	#superclass : #Object,
	#classInstVars : [
		'spaceshipsPositions',
		'currentSpaceshipID'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
GamePositions class >> with: anAmountOfSpaceships [
	spaceshipsPositions := Dictionary new. 
	1 to: anAmountOfSpaceships do: [ :spaceshipID | 
	spaceshipsPositions at: spaceshipID put: (Array new: 2).
	spaceshipsPositions at: spaceshipID at: 1 put: 0.
	spaceshipsPositions at: spaceshipID at: 2 put: 0.].
	currentSpaceshipID := 1.
]
