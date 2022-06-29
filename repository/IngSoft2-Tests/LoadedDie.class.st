"
I represent a Loaded Die, a specific type of Die.
"
Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'loadedSide'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
LoadedDie class >> assertValid: aNumberOfSides [

	aNumberOfSides > 0 ifFalse: [ 
		Error signal:
			'Loaded die cannot be created with a number lower than 0' ]
]

{ #category : #initialization }
LoadedDie class >> with: aNumberOfSides [ 

	self assertValid: aNumberOfSides.
	^ self new initializeWith: aNumberOfSides.
]

{ #category : #initialization }
LoadedDie >> initializeWith: aNumberOfSides [

	loadedSide := aNumberOfSides.
]

{ #category : #validation }
LoadedDie >> isValid [
	^ loadedSide > 0
]

{ #category : #dieRolling }
LoadedDie >> roll [

	^ loadedSide
]
