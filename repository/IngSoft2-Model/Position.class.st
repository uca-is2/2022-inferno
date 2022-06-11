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
Position class >> atLap: aLapNumber andSpot: aSpotNumber [ 
	^self new initializeAtLap: aLapNumber andSpot: aSpotNumber.
]

{ #category : #initialization }
Position >> initializeAtLap: aLapNumber andSpot: aSpotNumber [ 
	
	lapNumber := aLapNumber.
	spotNumber := aSpotNumber.
]

{ #category : #getters }
Position >> lapNumber [
	^ lapNumber
]

{ #category : #getters }
Position >> spotNumber [
	^ spotNumber
]
