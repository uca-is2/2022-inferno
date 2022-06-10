"
i represent a type of effect: wormhole
"
Class {
	#name : #Wormhole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
Wormhole >> applyTo: aBoard by: aSpaceship [ 
	| positionBeforeWormhole lapBeforeWormhole spotBeforeWormhole wormholeNumber |
	positionBeforeWormhole := aBoard positionOf: aSpaceship.
	lapBeforeWormhole := positionBeforeWormhole lapNumber.
	spotBeforeWormhole := positionBeforeWormhole spotNumber .
	wormholeNumber := 4.
	(lapBeforeWormhole = 0)
		ifTrue: [ 
			((spotBeforeWormhole - wormholeNumber )< 1)
				ifTrue: [ aBoard move: aSpaceship toLap: 0 andSpot: 1. ]
				ifFalse: [ aBoard move: aSpaceship toLap: 0 andSpot: (spotBeforeWormhole- wormholeNumber )] ]
		ifFalse: [ 
			((spotBeforeWormhole - wormholeNumber) < 1) ifTrue: [ 
				aBoard
					move:aSpaceship toLap: (lapBeforeWormhole - 1) andSpot: (spotBeforeWormhole + (aBoard lengthInSpots) - wormholeNumber)
					 ] ].
		^ (aBoard spaceshipPositions).
]
