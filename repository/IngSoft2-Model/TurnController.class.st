"
i represent a TurnController. Entity as referee or turn manager, whose responsibility is to tell which player should play next turn.
"
Class {
	#name : #TurnController,
	#superclass : #Object,
	#instVars : [
		'activeSpaceship',
		'spaceshipsOrderedByTurn',
		'activeSpaceshipID'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
TurnController class >> with: aMapOfSpaceshipsPositions [

	^ self new initializeWith: aMapOfSpaceshipsPositions
]

{ #category : #getters }
TurnController >> activeSpaceship [

	^ activeSpaceship
]

{ #category : #initialization }
TurnController >> initializeWith: aMapOfSpaceshipsPositions [

	spaceshipsOrderedByTurn := aMapOfSpaceshipsPositions keys.
	activeSpaceshipID := 1.
	activeSpaceship := spaceshipsOrderedByTurn at: 1
]

{ #category : #turnControlling }
TurnController >> nextSpaceshipInLine [

	activeSpaceshipID + 1 > spaceshipsOrderedByTurn size
		ifTrue: [ 
			activeSpaceshipID := 1.
			activeSpaceship := spaceshipsOrderedByTurn at: 1 ]
		ifFalse: [ 
			activeSpaceship := spaceshipsOrderedByTurn at:
				                   activeSpaceshipID + 1.
			activeSpaceshipID := activeSpaceshipID + 1 ]
]
