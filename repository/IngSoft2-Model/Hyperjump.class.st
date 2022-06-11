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
Hyperjump class >> createWith: aJumpsArray [ 
	1 to: aJumpsArray size do: [:each |  
		(aJumpsArray at: each) >= 0 ifFalse: [ 
		Error signal:
			'Hyperjump number cant be a negative number.' ].
		].
		^self new initializeWith: aJumpsArray.
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

{ #category : #initialization }
Hyperjump >> initializeWith: aJumpsArray [ 
	| sortedArray reversedArray |
	sortedArray := aJumpsArray sorted.
	reversedArray := sortedArray reversed.
	jumpsArray := aJumpsArray .
]
