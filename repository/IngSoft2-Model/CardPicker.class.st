"
i reprsent a type of effect: cardpicker

"
Class {
	#name : #CardPicker,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CardPicker >> applyTo: aBoard by: aSpaceship [ 
	| spaceships lapBeforeAtomicBomb |
	spaceships := (aBoard spaceshipPositions) keys.
	spaceships do: [:eachSpaceship |
		lapBeforeAtomicBomb := (aBoard positionOf: (eachSpaceship) ) lapNumber.
		 aBoard move: (eachSpaceship) toLap: lapBeforeAtomicBomb andSpot: 1. ].
	^ (aBoard spaceshipPositions)
]
