"
i represent a type of effect: hyperjump
"
Class {
	#name : #Hyperjump,
	#superclass : #Object,
	#instVars : [
		'jumpsArray'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Hyperjump class >> adjustTheDistanceMeasurement: aMeasure for: aJumpsArray [

	| aJumpsArrayInParsecs |
	aJumpsArrayInParsecs := OrderedCollection new: aJumpsArray size.
	(aMeasure = 'parsecs')
	ifFalse: [ 
		self assertValidMeasurement: aMeasure. 
		1 to: aJumpsArray size do: [:jumpValue | 
			aJumpsArrayInParsecs addFirst: ((aJumpsArray at: jumpValue)/3 )
		]
	]
	ifTrue:[
		aJumpsArrayInParsecs := aJumpsArray 
		].
	^ aJumpsArrayInParsecs
]

{ #category : #'class initialization' }
Hyperjump class >> assertAllJumpsArePositive: aJumpsArray [

	1 to: aJumpsArray size do: [ :each | 
		(aJumpsArray at: each) >= 0 ifFalse: [ 
			Error signal: 'Hyperjump number cant be a negative number.' ] ]
]

{ #category : #'class initialization' }
Hyperjump class >> assertValidMeasurement: aMeasure [

	aMeasure = 'lightyears' ifFalse: [ 
		Error signal:
			'Either parsecs or lightyears are the only valid measures' ]
]

{ #category : #'class initialization' }
Hyperjump class >> createWith: aJumpsArray measuredIn: aMeasure [

	| aJumpsArrayInParsecs |
	self assertAllJumpsArePositive: aJumpsArray.
	aJumpsArrayInParsecs := self adjustTheDistanceMeasurement: aMeasure for: aJumpsArray.
	^ self new initializeWith: aJumpsArrayInParsecs
]

{ #category : #applying }
Hyperjump >> applyTo: aBoard by: aSpaceship [ 
	| positionBeforeJump lapBeforeJump spotBeforeJump jumpNumber orderedJumpsArray  |
	positionBeforeJump := aBoard positionOf: aSpaceship.
	lapBeforeJump := positionBeforeJump lapNumber .
	spotBeforeJump := positionBeforeJump spotNumber.
	orderedJumpsArray := jumpsArray sorted.
	jumpsArray := orderedJumpsArray reverse.
	jumpNumber := self getJumpNumberInSpots: aBoard .
	aBoard move: aSpaceship fromEffectSpot: spotBeforeJump andLap: lapBeforeJump to: jumpNumber.
	^ (aBoard spaceshipPositions).
]

{ #category : #getters }
Hyperjump >> getJumpNumberInSpots: aBoard [
	|  hyperJumpValues lengthInParsecs amountOfSpots parsecsPerSpot parsecsForThisJump amountOfSpotsToJump |
	hyperJumpValues := jumpsArray.
	parsecsForThisJump := hyperJumpValues removeFirst.
	hyperJumpValues addLast: parsecsForThisJump .
	
	lengthInParsecs := aBoard lengthInParsecs.
	amountOfSpots := aBoard lengthInSpots.
	parsecsPerSpot := ( lengthInParsecs / amountOfSpots ).
	amountOfSpotsToJump := (parsecsForThisJump // parsecsPerSpot ).
	^ amountOfSpotsToJump
	
]

{ #category : #initialization }
Hyperjump >> initializeWith: aJumpsArray [ 
	| sortedArray reversedArray |
	sortedArray := aJumpsArray sorted.
	reversedArray := sortedArray reversed.
	jumpsArray := aJumpsArray .
]

{ #category : #getters }
Hyperjump >> jumpValues [
	^ jumpsArray.
]
