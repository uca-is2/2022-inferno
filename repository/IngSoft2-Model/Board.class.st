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

{ #category : #assertion }
Board class >> assertValidAmountOfLaps: anAmountOfLaps [

	anAmountOfLaps > 0 ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of laps lower than 0.' ]
]

{ #category : #assertion }
Board class >> assertValidAmountOfSpaceship: aCollectionOfSpaceships [

	aCollectionOfSpaceships size > 1 ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of spaceships lower than 2' ]
]

{ #category : #assertion }
Board class >> assertValidAmountOfSpots: anAmountOfSpots [

	(anAmountOfSpots isEmpty) ifTrue: [ 
		Error signal:
			'Board cannot be created with a number of spots lower than 1' ]
]

{ #category : #assertion }
Board class >> assertValidLengthInParsecs: anAmountOfParsecs [

	anAmountOfParsecs > 0 ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of spots lower than 0' ]
]

{ #category : #'class initialization' }
Board class >> with: aCollectionOfSpots withALengthOf: anAmountOfParsecs around: anAmountOfLaps playedBy: aCollectionOfSpaceships [

	self assertValidAmountOfSpots: aCollectionOfSpots.
	self assertValidLengthInParsecs: anAmountOfParsecs.
	self assertValidAmountOfLaps: anAmountOfLaps.
	self assertValidAmountOfSpaceship: aCollectionOfSpaceships.
	^ self new
		  initializeWith: aCollectionOfSpots
		  withALengthOf: anAmountOfParsecs
		  around: anAmountOfLaps
		  playedBy: aCollectionOfSpaceships
]

{ #category : #getters }
Board >> amountOfLaps [
	^laps.
]

{ #category : #effectApplying }
Board >> applyEffect: aSpaceship [
	self applyEffectTriggeredBy: aSpaceship
	
]

{ #category : #effectApplying }
Board >> applyEffectTriggeredBy: aSpaceship [
	| spotNumber |
	spotNumber := (self positionOf: aSpaceship) spotNumber .
	spaceshipsPositions := (layout at: spotNumber)effectAtSpot applyTo: self by: aSpaceship.
]

{ #category : #validation }
Board >> assertValidLap: aLapNumber [
	((aLapNumber <= laps)and:(aLapNumber >= 0))ifFalse: [ 
		Error signal:
			'Cannot move a spaceship to an invalid lap number.' ]
]

{ #category : #validation }
Board >> assertValidSpot: aSpotNumber [ 
	((aSpotNumber <= length) and: (aSpotNumber > 0))ifFalse: [ 
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

{ #category : #asserting }
Board >> isLapFinishedIf: spotBeforeRoll moves: rollNumber [

	^ ((spotBeforeRoll + rollNumber) >= (self lengthInSpots)).
]

{ #category : #validation }
Board >> isValid [
	^ length > 0.
]

{ #category : #getters }
Board >> lengthInParsecs [
	^ lengthInParsecs
]

{ #category : #getters }
Board >> lengthInSpots [
	^length.
]

{ #category : #playing }
Board >> move: aSpaceship fromSpot: spotBeforeRoll andLap: lapBeforeRoll to: rollNumber [

	| spotAfterLapping |
	(self isLapFinishedIf: spotBeforeRoll moves: rollNumber)
		ifTrue: [ 
			(lapBeforeRoll + 1 >=  laps)
				ifTrue: [ self moveSpaceshipToFinishLine: aSpaceship ]
				ifFalse: [ 
					spotAfterLapping := spotBeforeRoll + rollNumber -  length +1 .
					self
						move: aSpaceship
						toLap: lapBeforeRoll + 1
						andSpot: spotAfterLapping.
					self applyEffect: aSpaceship ] ]
		ifFalse: [ 
			self
				move: aSpaceship
				toLap: lapBeforeRoll
				andSpot: spotBeforeRoll + rollNumber.
			self applyEffect: aSpaceship ]
]

{ #category : #moving }
Board >> move: aSpaceship toLap: aLapNumber andSpot: aSpotNumber [ 
	self assertValidLap: aLapNumber.
	self assertValidSpot: aSpotNumber.
	spaceshipsPositions at: aSpaceship put: (Position atLap: aLapNumber andSpot: aSpotNumber).
]

{ #category : #'as yet unclassified' }
Board >> moveSpaceshipToFinishLine: aSpaceship [
	self move: aSpaceship toLap: laps andSpot: length.
]

{ #category : #getters }
Board >> positionOf: aSpaceship [
	^ spaceshipsPositions at: aSpaceship .
]

{ #category : #getters }
Board >> spaceshipPositions [
	^ spaceshipsPositions .
]
