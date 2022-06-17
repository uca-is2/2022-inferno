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
	spaceships  do: [:eachSpaceship |
		lapBeforeAtomicBomb := (aBoard positionOf: eachSpaceship ) lapNumber.
		 aBoard move: eachSpaceship toLap: lapBeforeAtomicBomb andSpot: 1. ].
	^ (aBoard spaceshipPositions)
]
