"
i represent the positioning of spaceships in a game of zathura
"
Class {
	#name : #GamePositions,
	#superclass : #Object,
	#instVars : [
		'spaceshipsPositions',
		'currentSpaceshipID',
		'amountOfLaps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
GamePositions class >> with: anAmountOfSpaceships around: laps [
	anAmountOfSpaceships  > 1 ifFalse: [ 
		Error signal:
			'GamePositions cannot be created with a number of spaceships lower than 2' ].
	laps > 1 ifFalse: [ 
		Error signal:
			'GamePositions cannot be created with a number of laps lower than 0' ].
	^ self new initializeWith: anAmountOfSpaceships around: laps.
]

{ #category : #accessing }
GamePositions >> currentSpaceshipId [
	^ currentSpaceshipID 
]

{ #category : #accessing }
GamePositions >> currentSpaceshipLap [
	^ spaceshipsPositions at: currentSpaceshipID at: 2
]

{ #category : #accessing }
GamePositions >> currentSpaceshipPosition [
	^ spaceshipsPositions at: currentSpaceshipID  at: 1
]

{ #category : #initialization }
GamePositions >> initializeWith: anAmountOfSpaceships around: laps [
	spaceshipsPositions := Dictionary new. 
	1 to: anAmountOfSpaceships do: [ :spaceshipID | 
	spaceshipsPositions at: spaceshipID put: (Array new: 2).
	spaceshipsPositions at: spaceshipID at: 1 put: 1.
	spaceshipsPositions at: spaceshipID at: 2 put: 0.].
	currentSpaceshipID := 1.
	amountOfLaps := laps
]

{ #category : #getters }
GamePositions >> laps [
	^ amountOfLaps .
]

{ #category : #moving }
GamePositions >> moveCurrentTo: spaceshipNewPosition [
	
		spaceshipsPositions at: currentSpaceshipID at: 1 put: spaceshipNewPosition
]

{ #category : #moving }
GamePositions >> moveCurrentTo: spaceshipNewPosition andLap: spaceshipNewLap [

	spaceshipsPositions
		at: currentSpaceshipID
		at: 1
		put: spaceshipNewPosition.
	spaceshipsPositions at: currentSpaceshipID at: 2 put: spaceshipNewLap
]

{ #category : #'changing state' }
GamePositions >> nextSpaceshipInLine [
	currentSpaceshipID := currentSpaceshipID + 1.
	currentSpaceshipID > spaceshipsPositions size ifTrue: [ 
	currentSpaceshipID := 1 ]
]
