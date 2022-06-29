"
i represent a position, with lap number and spot number.
"
Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'lapNumber',
		'spotNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Position class >> at: aLapNumber on: aSpotNumber [

	^ self new initializeAt: aLapNumber on: aSpotNumber
]

{ #category : #comparison }
Position >> > aPosition [ 

	| lapsOfSpaceshipA lapsOfSpaceshipB spotsOfSpaceshipA spotsOfSpaceshipB |
	
	lapsOfSpaceshipA := self lapNumber.
	lapsOfSpaceshipB := aPosition lapNumber .
	spotsOfSpaceshipA := self spotNumber.
	spotsOfSpaceshipB := aPosition spotNumber.
	^((lapsOfSpaceshipA > lapsOfSpaceshipB) or: (lapsOfSpaceshipA = lapsOfSpaceshipB and: (spotsOfSpaceshipA > spotsOfSpaceshipB)))
]

{ #category : #initialization }
Position >> initializeAt: aLapNumber on: aSpotNumber [

	lapNumber := aLapNumber.
	spotNumber := aSpotNumber
]

{ #category : #getters }
Position >> lapNumber [

	^ lapNumber
]

{ #category : #getters }
Position >> spotNumber [

	^ spotNumber
]
