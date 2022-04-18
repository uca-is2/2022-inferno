Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'loadedSide'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
LoadedDie class >> assertValid: aLoadedSide [
	aLoadedSide > 0 ifFalse: [ Error signal: 'Die should be loaded with number greater than 0' ] 

]

{ #category : #'instance creation' }
LoadedDie class >> with: aLoadedSide [

	self assertValid: aLoadedSide .
	^ self new initializeWith: aLoadedSide 
]

{ #category : #initialization }
LoadedDie >> initializeWith: aLoadedSide [
	loadedSide := aLoadedSide.
]

{ #category : #dieRolling }
LoadedDie >> roll [
	^loadedSide .
]
