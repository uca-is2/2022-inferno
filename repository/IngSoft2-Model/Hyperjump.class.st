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

{ #category : #assertions }
Hyperjump class >> assertValid: aJumpsArray [ 
	aJumpsArray do: [ :distance | (distance amount) >= 0 ifFalse: [ 
			Error signal: 'Values of the collection cannot be a negative number' ] ].
]

{ #category : #'class initialization' }
Hyperjump class >> createWith: aJumpsArray [ 
	self assertValid: aJumpsArray.
	^self new initializeWith: aJumpsArray.
]

{ #category : #applying }
Hyperjump >> applyTo: aBoard by: aSpaceship [

	| positionBeforeJump jumpNumber |
	positionBeforeJump := aBoard positionOf: aSpaceship.
	jumpNumber := self getJumpNumberInSpots: aBoard.
	aBoard
		move: aSpaceship
		withoutTriggeringNewEffectsfrom: positionBeforeJump
		to: jumpNumber
]

{ #category : #getters }
Hyperjump >> getJumpNumberInSpots: aBoard [

	| hyperJumpValues parsecsForThisJump lengthInParsecs amountOfSpots parsecsPerSpot amountOfSpotsToJump amountOfParsecsToJump |
	hyperJumpValues := jumpsArray.
	parsecsForThisJump := hyperJumpValues removeFirst.
	hyperJumpValues addLast: parsecsForThisJump.
	lengthInParsecs := aBoard lengthInParsecs.
	amountOfSpots := aBoard lengthInSpots.
	parsecsPerSpot := lengthInParsecs / amountOfSpots.
	amountOfParsecsToJump := parsecsForThisJump amountInParsecs.
	amountOfSpotsToJump := amountOfParsecsToJump // parsecsPerSpot.
	^ amountOfSpotsToJump
]

{ #category : #initialization }
Hyperjump >> initializeWith: aJumpsArray [

	jumpsArray := aJumpsArray sorted reversed
]

{ #category : #getters }
Hyperjump >> jumpValues [

	^ jumpsArray
]
