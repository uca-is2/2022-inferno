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
Spot class >> create [
	| noEffect |
	noEffect := NoEffect new.
	^ self new initializeWith: noEffect.
	
]

{ #category : #getters }
Spot >> effectAtSpot [

	^ effect
]

{ #category : #initialization }
Spot >> initializeWith: aNoEffect [ 
	
	effect := aNoEffect.
]

{ #category : #setters }
Spot >> loadEffect: anEffect [

	effect := anEffect 
	
]
