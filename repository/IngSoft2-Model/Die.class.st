"
I represent a Die.
"
Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'numberOfSides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Die class >> assertValid: aNumberOfSides [

	aNumberOfSides > 2 ifFalse: [ 
		Error signal:
			'Die cannot be created with a number of sides lower than 3' ]
]

{ #category : #initialization }
Die class >> with: aNumberOfSides [

	self assertValid: aNumberOfSides.
	^ self new initializeWith: aNumberOfSides
]

{ #category : #initialization }
Die >> initializeWith: aNumberOfSides [

	numberOfSides := aNumberOfSides
]

{ #category : #validation }
Die >> isValid [

	^ numberOfSides > 2
]

{ #category : #dieRolling }
Die >> roll [

	^ numberOfSides atRandom
]
