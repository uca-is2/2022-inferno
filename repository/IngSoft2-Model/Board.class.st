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
		  withALengthOf: aLengthInParsecs
		  around: anAmountOfLaps
		  playedBy: aCollectionOfSpaceships
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
	[resultOfEffectApplying assertThatIsACard] on: Exception do: [ ^ self ].
	cardPicked := resultOfEffectApplying.
	^ cardPicked
]

{ #category : #effectApplying }
Board >> applyLastEffectTo: aSpaceship [

	| resultOfEffectApplying cardPicked |
	resultOfEffectApplying := lastEffectAplied
		                          applyTo: self
		                          by: aSpaceship.
	resultOfEffectApplying class = Dictionary
		ifTrue: [ spaceshipsPositions := resultOfEffectApplying ]
		ifFalse: [ 
			cardPicked := resultOfEffectApplying.
			^ cardPicked ]
]

{ #category : #getters }
Board >> dealer [
	^ cardDealer.
]

{ #category : #initialization }
Board >> initializeWith: aCollectionOfSpots withALengthOf: anAmountOfParsecs around: anAmountOfLaps playedBy: aCollectionOfSpaceships [

	| amountOfSpaceships |
	layout := aCollectionOfSpots.
	lengthInParsecs := anAmountOfParsecs.
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

{ #category : #validation }
Board >> isValid [

	^ length > 0
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

	| lengthInSpots positionInTotalSpots nextPositionInTotalSpots nextSpotCandidate nextLapCandidate spotBeforeRoll lapBeforeRoll|
	spotBeforeRoll:= positionBeforeRoll spotNumber.
	lapBeforeRoll := positionBeforeRoll lapNumber.
	lengthInSpots := self lengthInSpots.
	positionInTotalSpots := lengthInSpots * lapBeforeRoll
	                        + spotBeforeRoll.
	nextPositionInTotalSpots := positionInTotalSpots + rollNumber.
	nextSpotCandidate := nextPositionInTotalSpots rem: lengthInSpots.
	nextLapCandidate := nextPositionInTotalSpots // lengthInSpots.
	nextPositionInTotalSpots < 1
		ifTrue: [ self move: aSpaceship toLap: 0 andSpot: 1 ]
		ifFalse: [ 
			nextSpotCandidate == 0
				ifTrue: [ 
					self
						move: aSpaceship
						toLap: nextLapCandidate - 1
						andSpot: lengthInSpots ]
				ifFalse: [ 
				self move: aSpaceship toLap: nextLapCandidate andSpot: nextSpotCandidate ] ]
]

{ #category : #playing }
Board >> move: aSpaceship from: positionBeforeRoll to: rollNumber [

	| spotAfterLapping cardPicked spotBeforeRoll lapBeforeRoll |
	spotBeforeRoll:= positionBeforeRoll spotNumber.
	lapBeforeRoll := positionBeforeRoll lapNumber.
	(self isLapFinishedIf: spotBeforeRoll moves: rollNumber)
		ifTrue: [ 
			lapBeforeRoll + 1 >= laps
				ifTrue: [ self moveToFinishLine: aSpaceship ]
				ifFalse: [ 
					spotAfterLapping := spotBeforeRoll + rollNumber - length.
					self
						move: aSpaceship
						toLap: lapBeforeRoll + 1
						andSpot: spotAfterLapping.
					cardPicked := self applyEffect: aSpaceship ] ]
		ifFalse: [ 
			(self isLapDecreasedIf: spotBeforeRoll moves: rollNumber)
				ifFalse: [ 
					self
						move: aSpaceship
						toLap: lapBeforeRoll
						andSpot: spotBeforeRoll + rollNumber ]
				ifTrue: [ 
				self move: aSpaceship back: rollNumber from: spotBeforeRoll ].
			cardPicked := self applyEffect: aSpaceship ]
]

{ #category : #moving }
Board >> move: aSpaceship fromEffectSpot: spotBeforeRoll andLap: lapBeforeRoll to: rollNumber [

	| spotAfterLapping |
	rollNumber == 0
		ifTrue: [ 
		self move: aSpaceship toLap: lapBeforeRoll andSpot: spotBeforeRoll ]
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
								toLap: lapBeforeRoll + 1
								andSpot: spotAfterLapping ] ]
				ifFalse: [ 
					self
						move: aSpaceship
						toLap: lapBeforeRoll
						andSpot: spotBeforeRoll + rollNumber ] ]
]

{ #category : #moving }
Board >> move: aSpaceship toLap: aLapNumber andSpot: aSpotNumber [
	spaceshipsPositions
		at: aSpaceship
		put: (Position at: aLapNumber on: aSpotNumber)
]

{ #category : #moving }
Board >> moveAllSpaceshipsToStartOfLap [
	| spaceships lapBeforeAtomicBomb |
	spaceships := self spaceshipPositions keys.
	spaceships do: [ :eachSpaceship | 
		lapBeforeAtomicBomb := (self positionOf: eachSpaceship) lapNumber.
		self move: eachSpaceship toLap: lapBeforeAtomicBomb andSpot: 1 ].
]

{ #category : #moving }
Board >> moveToFinishLine: aSpaceship [

	self move: aSpaceship toLap: laps andSpot: length
]

{ #category : #getter }
Board >> orderOfKeys: spaceshipArrayOfKeys [

	| orderedRankingArray aux |
	orderedRankingArray := OrderedCollection new:
		                       spaceshipArrayOfKeys size.
	1 to: spaceshipArrayOfKeys size do: [ :spaceship | 
		aux := Array new: 3.
		aux at: 1 put: (spaceshipArrayOfKeys at: spaceship).
		aux
			at: 2
			put:
				(spaceshipsPositions at: (spaceshipArrayOfKeys at: spaceship))
					lapNumber.
		aux
			at: 3
			put:
				(spaceshipsPositions at: (spaceshipArrayOfKeys at: spaceship))
					spotNumber.
		orderedRankingArray addLast: aux ].
	^ orderedRankingArray
]

{ #category : #getters }
Board >> positionOf: aSpaceship [

	^ spaceshipsPositions at: aSpaceship
]

{ #category : #getter }
Board >> rankingOfSpaceships [

	| spaceshipsArray positionOfSpaceshipA positionOfSpaceshipB lapsOfSpaceshipA lapsOfSpaceshipB spotsOfSpaceshipA spotsOfSpaceshipB rankingOfSpaceships |
	spaceshipsArray := self spaceshipPositions keys. "['Razor', 'Meteoro, 'SC30']"

	spaceshipsArray sort: [ :spaceShipA :spaceShipB | 
		positionOfSpaceshipA := self positionOf: spaceShipA.
		positionOfSpaceshipB := self positionOf: spaceShipB.
		lapsOfSpaceshipA := positionOfSpaceshipA lapNumber.
		lapsOfSpaceshipB := positionOfSpaceshipB lapNumber.
		spotsOfSpaceshipA := positionOfSpaceshipA spotNumber.
		spotsOfSpaceshipB := positionOfSpaceshipB spotNumber.

		lapsOfSpaceshipA > lapsOfSpaceshipB
		| (lapsOfSpaceshipA = lapsOfSpaceshipB
			 & (spotsOfSpaceshipA > spotsOfSpaceshipB)) ].

	"Meteoro, Razor SC30"

	rankingOfSpaceships := self orderOfKeys: spaceshipsArray.
	^ rankingOfSpaceships
]

{ #category : #getters }
Board >> spaceshipPositions [

	^ spaceshipsPositions
]
