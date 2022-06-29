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
		'spaceshipsPositions',
		'lastEffectAplied',
		'cardDealer'
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

	anAmountOfSpots isEmpty ifTrue: [ 
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
Board class >> with: aCollectionOfSpots and: aLengthInParsecs playedFor: anAmountOfLaps by: aCollectionOfSpaceships [

	self assertValidAmountOfSpots: aCollectionOfSpots.
	self assertValidLengthInParsecs: aLengthInParsecs.
	self assertValidAmountOfLaps: anAmountOfLaps.
	self assertValidAmountOfSpaceship: aCollectionOfSpaceships.
	^ self new
		  initializeWith: aCollectionOfSpots
		  and: aLengthInParsecs
		  around: anAmountOfLaps
		  playedBy: aCollectionOfSpaceships
]

{ #category : #getters }
Board >> addEachPositionToRanking: spaceshipArrayOfKeys [

	| orderedRanking |
	orderedRanking := Dictionary new: spaceshipArrayOfKeys size.
	spaceshipArrayOfKeys do: [ :eachSpaceship | 
		orderedRanking
			at: eachSpaceship
			put: (spaceshipsPositions at: eachSpaceship) ].
	^ orderedRanking
]

{ #category : #getters }
Board >> amountOfLaps [

	^ laps
]

{ #category : #effectApplying }
Board >> applyEffect: aSpaceship [

	^ self applyEffectTriggeredBy: aSpaceship
]

{ #category : #effectApplying }
Board >> applyEffectTriggeredBy: aSpaceship [

	| spotNumber resultOfEffectApplying cardPicked |
	spotNumber := (self positionOf: aSpaceship) spotNumber.
	lastEffectAplied := (layout at: spotNumber) effectAtSpot.
	resultOfEffectApplying := lastEffectAplied
		                          applyTo: self
		                          by: aSpaceship.
	[ resultOfEffectApplying assertThatIsACard ]
		on: Exception
		do: [ ^ self ].
	cardPicked := resultOfEffectApplying.
	^ cardPicked
]

{ #category : #effectApplying }
Board >> applyLastEffectTo: aSpaceship [

	| resultOfEffectApplying cardPicked |
	resultOfEffectApplying := lastEffectAplied
		                          applyTo: self
		                          by: aSpaceship.
	[ resultOfEffectApplying assertThatIsACard ]
		on: Exception
		do: [ ^ self ].
	cardPicked := resultOfEffectApplying.
	^ cardPicked
]

{ #category : #getters }
Board >> dealer [
	^ cardDealer.
]

{ #category : #initialization }
Board >> initializeWith: aCollectionOfSpots and: aLengthInParsecs around: anAmountOfLaps playedBy: aCollectionOfSpaceships [

	| amountOfSpaceships |
	layout := aCollectionOfSpots.
	lengthInParsecs := aLengthInParsecs.
	laps := anAmountOfLaps.
	length := aCollectionOfSpots size.
	amountOfSpaceships := aCollectionOfSpaceships size.
	lastEffectAplied := NoEffect new.
	spaceshipsPositions := Dictionary new: amountOfSpaceships.
	cardDealer := Dealer new.
	1 to: amountOfSpaceships do: [ :spaceship | 
		spaceshipsPositions
			at: (aCollectionOfSpaceships at: spaceship)
			put: (Position at: 0 on: 1) ]
]

{ #category : #asserting }
Board >> isLapDecreasedIf: spotBeforeRoll moves: rollNumber [

	^ spotBeforeRoll + rollNumber < 1
]

{ #category : #asserting }
Board >> isLapFinishedIf: spotBeforeRoll moves: rollNumber [

	^ spotBeforeRoll + rollNumber > self lengthInSpots
]

{ #category : #getters }
Board >> lengthInParsecs [

	^ lengthInParsecs
]

{ #category : #getters }
Board >> lengthInSpots [

	^ length
]

{ #category : #moving }
Board >> move: aSpaceship back: rollNumber from: positionBeforeRoll [

	| lengthInSpots positionInTotalSpots nextPositionInTotalSpots nextSpotCandidate nextLapCandidate spotBeforeRoll lapBeforeRoll |
	spotBeforeRoll := positionBeforeRoll spotNumber.
	lapBeforeRoll := positionBeforeRoll lapNumber.
	lengthInSpots := self lengthInSpots.
	positionInTotalSpots := lengthInSpots * lapBeforeRoll
	                        + spotBeforeRoll.
	nextPositionInTotalSpots := positionInTotalSpots + rollNumber.
	nextSpotCandidate := nextPositionInTotalSpots rem: lengthInSpots.
	nextLapCandidate := nextPositionInTotalSpots // lengthInSpots.
	nextPositionInTotalSpots < 1
		ifTrue: [ self move: aSpaceship to: 0 and: 1 ]
		ifFalse: [ 
			nextSpotCandidate == 0
				ifTrue: [ 
				self move: aSpaceship to: nextLapCandidate - 1 and: lengthInSpots ]
				ifFalse: [ 
				self move: aSpaceship to: nextLapCandidate and: nextSpotCandidate ] ]
]

{ #category : #playing }
Board >> move: aSpaceship from: positionBeforeRoll to: rollNumber [

	| spotAfterLapping cardPicked spotBeforeRoll lapBeforeRoll |
	spotBeforeRoll := positionBeforeRoll spotNumber.
	lapBeforeRoll := positionBeforeRoll lapNumber.
	(self isLapFinishedIf: spotBeforeRoll moves: rollNumber)
		ifTrue: [ 
			lapBeforeRoll + 1 >= laps
				ifTrue: [ cardPicked := self moveToFinishLine: aSpaceship ]
				ifFalse: [ 
					spotAfterLapping := spotBeforeRoll + rollNumber - length.
					self move: aSpaceship to: lapBeforeRoll + 1 and: spotAfterLapping.
					cardPicked := self applyEffect: aSpaceship ] ]
		ifFalse: [ 
			(self isLapDecreasedIf: spotBeforeRoll moves: rollNumber)
				ifFalse: [ 
					self
						move: aSpaceship
						to: lapBeforeRoll
						and: spotBeforeRoll + rollNumber ]
				ifTrue: [ 
				self move: aSpaceship back: rollNumber from: spotBeforeRoll ].
			cardPicked := self applyEffect: aSpaceship ].

	^ cardPicked
]

{ #category : #moving }
Board >> move: aSpaceship to: aLapNumber and: aSpotNumber [

	spaceshipsPositions
		at: aSpaceship
		put: (Position at: aLapNumber on: aSpotNumber)
]

{ #category : #moving }
Board >> move: aSpaceship withoutTriggeringNewEffectsfrom: positionBeforeRoll to: rollNumber [

	| spotAfterLapping lapBeforeRoll spotBeforeRoll|
	lapBeforeRoll := positionBeforeRoll lapNumber.
	spotBeforeRoll := positionBeforeRoll spotNumber. 
	rollNumber == 0
		ifTrue: [ 
		self move: aSpaceship to: lapBeforeRoll and: spotBeforeRoll ]
		ifFalse: [ 
			(self isLapFinishedIf: spotBeforeRoll moves: rollNumber)
				ifTrue: [ 
					lapBeforeRoll + 1 >= laps
						ifTrue: [ self moveToFinishLine: aSpaceship ]
						ifFalse: [ 
							spotAfterLapping := spotBeforeRoll + rollNumber - length.
							spotAfterLapping == 0 ifTrue: [ spotAfterLapping := length ].
							self
								move: aSpaceship
								to: lapBeforeRoll + 1
								and: spotAfterLapping ] ]
				ifFalse: [ 
					self
						move: aSpaceship
						to: lapBeforeRoll
						and: spotBeforeRoll + rollNumber ] ]
]

{ #category : #moving }
Board >> moveAllSpaceshipsToStartOfLap [
	| spaceships lapBeforeAtomicBomb |
	spaceships := self spaceshipPositions keys.
	spaceships do: [ :eachSpaceship | 
		lapBeforeAtomicBomb := (self positionOf: eachSpaceship) lapNumber.
		self move: eachSpaceship to: lapBeforeAtomicBomb and: 1 ].
]

{ #category : #moving }
Board >> moveToFinishLine: aSpaceship [

	self move: aSpaceship to: laps and: length
]

{ #category : #getters }
Board >> positionOf: aSpaceship [

	^ spaceshipsPositions at: aSpaceship
]

{ #category : #getters }
Board >> rankingOfSpaceships [

	| spaceshipsArray |
	spaceshipsArray := self spaceshipPositions keys.
	self sortSpaceshipsByPosition: spaceshipsArray.
	^ (self addEachPositionToRanking: spaceshipsArray).
]

{ #category : #getters }
Board >> sortSpaceshipsByPosition: spaceshipsArray [

	| positionOfFirstSpaceship positionOfSecondSpaceship |
	spaceshipsArray sort: [ :firstSpaceship :secondSpaceship | 
		positionOfFirstSpaceship := self positionOf: firstSpaceship.
		positionOfSecondSpaceship := self positionOf: secondSpaceship.
		positionOfFirstSpaceship > positionOfSecondSpaceship ]
]

{ #category : #getters }
Board >> spaceshipPositions [

	^ spaceshipsPositions
]
