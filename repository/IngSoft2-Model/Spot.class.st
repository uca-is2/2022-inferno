"
i represent a spot in a game board
"
Class {
	#name : #Spot,
	#superclass : #Object,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Spot class >> createWith: anEffect [

	^ self new initializeWith: anEffect
]

{ #category : #getters }
Spot >> effectAtSpot [

	^ effect
]

{ #category : #initialization }
Spot >> initializeWith: anEffect [

	effect := anEffect
]
