"
I represent a type of distance: a Lightyear
"
Class {
	#name : #Lightyear,
	#superclass : #Object,
	#instVars : [
		'distance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Lightyear class >> assertValid: aDistance [

	aDistance >=0 ifFalse: [ 
		Error signal: 'LightYears value has to be greater or equal than zero' ].
]

{ #category : #'instance creation' }
Lightyear class >> distanceOf: aDistance [

	self assertValid: aDistance.
	^ self new initializeWith: aDistance
]

{ #category : #actions }
Lightyear >> <= aDistance [
	
	^ self amountInParsecs <= aDistance amountInParsecs .
]

{ #category : #actions }
Lightyear >> amount [

	^ distance
]

{ #category : #actions }
Lightyear >> amountInLightYears [

	^ distance
]

{ #category : #actions }
Lightyear >> amountInParsecs [

	^ distance / 3
]

{ #category : #initialize }
Lightyear >> initializeWith: aDistance [

	distance := aDistance
]

{ #category : #validation }
Lightyear >> isValid [
	^ distance >=0
]
