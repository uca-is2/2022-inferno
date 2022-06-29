"
i represent a type of effect: moonwalk
"
Class {
	#name : #Moonwalk,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Moonwalk class >> assertValid: aMoonwalkNumber [

	aMoonwalkNumber >= 0 ifFalse: [ 
		Error signal: 'Moonwalk number cant be a negative number.' ]
]

{ #category : #initialization }
Moonwalk class >> createWith: aMoonwalkNumber [

	self assertValid: aMoonwalkNumber.
	^ self new initializeWith: aMoonwalkNumber
]

{ #category : #applying }
Moonwalk >> applyTo: aBoard by: aSpaceship [

	| positionBeforeMoonwalk spaceships |
	spaceships := aBoard spaceshipPositions keys.
	 spaceships do: [ :eachSpaceship | 
		(eachSpaceship) == aSpaceship ifFalse: [ 
			positionBeforeMoonwalk := aBoard positionOf: (eachSpaceship).
			aBoard
				move: (eachSpaceship)
				back: (number*(-1))
				from: positionBeforeMoonwalk ] ].
]

{ #category : #initialization }
Moonwalk >> initializeWith: aMoonwalkNumber [

	number := aMoonwalkNumber
]
