"
I represent a Loaded Die, a specific type of Die.
"
Class {
	#name : #LoadedDie,
	#superclass : #Die,
	#instVars : [
		'loadedSide'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
LoadedDie class >> with: aNumberOfSides loadedWith: aLoadedSide [

	aNumberOfSides > 2 ifFalse: [ 
		Error signal:
			'Die cannot be created with a number of sides lower than 3' ].
	aLoadedSide <= aNumberOfSides ifFalse: [ 
		Error signal:
			'The loaded side cannot be greater than the number of sides or lower than 0' ].
	^ self new initializeWith: aNumberOfSides withLoadedSide: aLoadedSide
]

{ #category : #initialization }
LoadedDie >> initializeWith: aNumberOfSides withLoadedSide: aLoadedSide [

	numberOfSides := aNumberOfSides.
	loadedSide := aLoadedSide
]

{ #category : #validation }
LoadedDie >> isValid [

	^ numberOfSides > 2 & loadedSide < numberOfSides
]

{ #category : #dieRolling }
LoadedDie >> roll [

	^ loadedSide
]
