"
i represent a type of effect: atomicbomb
"
Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
AtomicBomb >> applyTo: aBoard by: aSpaceship [ 
	| spaceships lapBeforeAtomicBomb |
	spaceships := (aBoard spaceshipPositions) keys.
	1 to: (spaceships size) do: [:eachSpaceship |
		lapBeforeAtomicBomb := (aBoard positionOf: (spaceships at: eachSpaceship) ) lapNumber.
		 aBoard move: (spaceships at: eachSpaceship) toLap: lapBeforeAtomicBomb andSpot: 1. ].
	^ (aBoard spaceshipPositions)
]
