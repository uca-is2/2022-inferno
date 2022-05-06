"
I represent a Board of slots to be played with.

"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfSlots'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> with: aNumberOfSlots [

	aNumberOfSlots > 0 ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of slots lower than 1' ].
	^ self new initializeWith: aNumberOfSlots
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfSlots [

	numberOfSlots := aNumberOfSlots
]

{ #category : #validation }
Board >> isValid [

	^ numberOfSlots > 0
]

{ #category : #'accessing - attributes' }
Board >> lenght [

	^ numberOfSlots
]
