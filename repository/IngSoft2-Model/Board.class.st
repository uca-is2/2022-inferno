"
i represent a board where a game can be played
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'layout',
		'lengthInParsecs',
		'laps',
		'length',
		'spaceshipsPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Board class >> assertValidAmountOfLaps: anAmountOfLaps [

	anAmountOfLaps > 0 ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of laps lower than 0.' ]
]

{ #category : #'class initialization' }
Board class >> assertValidAmountOfSpaceship: aCollectionOfSpaceships [

	aCollectionOfSpaceships size > 1 ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of spaceships lower than 2' ]
]

{ #category : #'class initialization' }
Board class >> assertValidAmountOfSpots: anAmountOfSpots [

	(anAmountOfSpots isEmpty) ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of spots lower than 2' ]
]

{ #category : #'class initialization' }
Board class >> assertValidLengthInParsecs: anAmountOfParsecs [

	anAmountOfParsecs > 0 ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of spots lower than 0' ]
]

{ #category : #'class initialization' }
Board class >> with: anAmountOfSpots withALenghtOf: anAmountOfParsecs around: anAmountOfLaps playedBy: aCollectionOfSpaceships [

	self assertValidAmountOfSpots: anAmountOfSpots.
	self assertValidLengthInParsecs: anAmountOfParsecs.
	self assertValidAmountOfLaps: anAmountOfLaps.
	self assertValidAmountOfSpaceship: aCollectionOfSpaceships.
	^ self new
		  initializeWith: anAmountOfSpots
		  withALengthOf: anAmountOfParsecs
		  around: anAmountOfLaps
		  playedBy: aCollectionOfSpaceships
]

{ #category : #validation }
Board >> assertValidLap: aLapNumber [
	((aLapNumber < laps)and:(aLapNumber >= 0))ifFalse: [ 
		Error signal:
			'Cannot move a spaceship to an invalid lap number.' ]
]

{ #category : #validation }
Board >> assertValidSpot: aSpotNumber [ 
	((aSpotNumber < length) and:(aSpotNumber > 0))ifFalse: [ 
		Error signal:
			'Cannot move a spaceship to an invalid spot number' ]
]

{ #category : #initialization }
Board >> initializeWith: aCollectionOfSpots withALengthOf: anAmountOfParsecs around: anAmountOfLaps playedBy: aCollectionOfSpaceships [ 

	| amountOfSpaceships |
	layout := aCollectionOfSpots.
	lengthInParsecs := anAmountOfParsecs.
	laps := anAmountOfLaps.
	length := aCollectionOfSpots size.
	amountOfSpaceships := aCollectionOfSpaceships size.
	spaceshipsPositions := Dictionary new: amountOfSpaceships.
	1 to: amountOfSpaceships do: [: spaceship |  
	spaceshipsPositions at: (aCollectionOfSpaceships at: spaceship) put: (Position atLap: 0 andSpot: 1).].  
]

{ #category : #validation }
Board >> isValid [
	^ length > 0.
]

{ #category : #moving }
Board >> move: aSpaceship toLap: aLapNumber andSpot: aSpotNumber [ 
	self assertValidLap: aLapNumber.
	self assertValidSpot: aSpotNumber.
	spaceshipsPositions at: aSpaceship put: (Position atLap: aLapNumber andSpot: aSpotNumber).
]

{ #category : #getters }
Board >> positionOf: aSpaceship [
	^ spaceshipsPositions at: aSpaceship .
]
