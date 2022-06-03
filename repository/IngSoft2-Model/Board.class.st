"
i represent a board that contains a series of spots.
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'layout',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> with: aNumberOfSpots withALenghtOf: anAmountOfParsecs [ 
	((aNumberOfSpots > 0)) ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of slots lower than 1 ' ].
	^ self new initializeWith: aNumberOfSpots andNumberOfParsecs: anAmountOfParsecs 
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfSpots andNumberOfParsecs: aLenghtInParsecs [

	layout := Array new: aNumberOfSpots.
	layout := layout collect:[:each | Spot create.].	
	parsecs := aLenghtInParsecs.
]

{ #category : #getters }
Board >> layout [
	^ layout
]

{ #category : #getters }
Board >> lenghtInParsecs [
	^ parsecs 
]
