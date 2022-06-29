Class {
	#name : #HyperJump2,
	#superclass : #Object,
	#instVars : [
		'jumpsArray'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
HyperJump2 class >> assertValid: aJumpsArray [ 
	aJumpsArray do: [ :distance | (distance amount) >= 0 ifFalse: [ 
			Error signal: 'Values of the collection cannot be a negative number' ] ].
]

{ #category : #'class initialization' }
HyperJump2 class >> createWith: aJumpsArray [

	self assertValid: aJumpsArray.
	^self new initializeWith: aJumpsArray.
	
]

{ #category : #private }
HyperJump2 >> applyTo: aBoard by: aSpaceship [ 
	| jump positionBeforeJump jumpInParsecs jumpNumber |
	positionBeforeJump:= aBoard positionOf: aSpaceship.
	jump:= jumpsArray first.
	jumpsArray := (jumpsArray reject: [:each |
		each=jump]),{jump}.
	jumpInParsecs:= jump amountInParsecs.
	jumpNumber:= self getJumpNumberInSpots: aBoard.
	
	aBoard move: aSpaceship withoutTriggeringNewEffectsfrom: positionBeforeJump to: jumpNumber
]

{ #category : #getters }
HyperJump2 >> getJumpNumberInSpots: aBoard [ 
	
	| hyperJumpValues parsecsForThisJump lengthInParsecs amountOfSpots parsecsPerSpot amountOfSpotsToJump |
	hyperJumpValues:= jumpsArray.
	parsecsForThisJump:= hyperJumpValues removeFirst.
	hyperJumpValues addLast: parsecsForThisJump.
	lengthInParsecs:=aBoard  lengthInParsecs.
	amountOfSpots:=aBoard lengthInSpots.
	parsecsPerSpot:=lengthInParsecs/amountOfSpots.
	amountOfSpotsToJump:= (parsecsForThisJump amount) // parsecsPerSpot.
	^ amountOfSpotsToJump.
]

{ #category : #initialization }
HyperJump2 >> initializeWith: aJumpsArray [

	jumpsArray:= aJumpsArray sorted reverse.
]
