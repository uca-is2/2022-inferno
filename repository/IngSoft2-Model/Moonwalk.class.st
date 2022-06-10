"
i represent a type of effect: moonwalk
"
Class {
	#name : #Moonwalk,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Moonwalk class >> createWith: aMoonwalkNumber [ 
		aMoonwalkNumber >= 0 ifFalse: [ 
		Error signal:
			'Moonwalk number cant be a negative number.' ].
		^self new initializeWith: aMoonwalkNumber.
]

{ #category : #applying }
Moonwalk >> applyTo: aBoard by: aSpaceship [

	| positionBeforeMoonwalk spaceships|
	spaceships := (aBoard spaceshipPositions)keys.
	1 to: (spaceships size) do: [:each | 
		((spaceships at: each)== aSpaceship)ifFalse: [ 
			positionBeforeMoonwalk := aBoard positionOf: (spaceships at: each).
			self moonwalk: (spaceships at: each) from: positionBeforeMoonwalk on: aBoard.
		] 
	].
	^ aBoard spaceshipPositions
]

{ #category : #initialization }
Moonwalk >> initializeWith: aMoonwalkNumber [ 
	number:= aMoonwalkNumber.
	
]

{ #category : #applying }
Moonwalk >> moonwalk: aSpaceship from: positionBeforeMoonwalk on: aBoard [

	| lapBeforeMoonwalk spotBeforeMoonwalk lapsToDecrease spotsToDecrease |
	lapBeforeMoonwalk := positionBeforeMoonwalk lapNumber.
	spotBeforeMoonwalk := positionBeforeMoonwalk spotNumber.
	lapBeforeMoonwalk = 0
		ifTrue: [ 
			spotBeforeMoonwalk - number < 1
				ifTrue: [ aBoard move: aSpaceship toLap: 0 andSpot: 1 ]
				ifFalse: [ 
					aBoard
						move: aSpaceship
						toLap: 0
						andSpot: spotBeforeMoonwalk - number ] ]
		ifFalse: [ 
			lapsToDecrease := (number / (aBoard lengthInSpots))asInteger. 
			spotsToDecrease := number - (lapsToDecrease* aBoard lengthInSpots).
			((lapBeforeMoonwalk - lapsToDecrease) < 1)ifTrue:[
				aBoard move: aSpaceship toLap: 0 andSpot: 1.
				]
			ifFalse:[
				aBoard move: aSpaceship toLap: (lapBeforeMoonwalk - lapsToDecrease) andSpot: (spotBeforeMoonwalk -spotsToDecrease ) ]
			 ].
]
