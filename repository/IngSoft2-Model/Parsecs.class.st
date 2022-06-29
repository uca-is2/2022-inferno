"
I represent a type of distance: a Parsec
"
Class {
	#name : #Parsecs,
	#superclass : #Distance,
	#instVars : [
		'distance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance cre' }
Parsecs class >> assertValid: aTotalDistance [

	aTotalDistance >=0 ifFalse: [ 
		Error signal: 'Parsecs value has to be greater or equal than zero' ]
]

{ #category : #'instance cre' }
Parsecs class >> with: aTotalDistance [

	self assertValid: aTotalDistance.
	^ self new initializeWith: aTotalDistance
]

{ #category : #accesing }
Parsecs >> amount [

	^ distance
]

{ #category : #actions }
Parsecs >> amountInLightYears [ 

	^ distance*3
]

{ #category : #actions }
Parsecs >> amountInParsecs [

	^ distance
]

{ #category : #initialization }
Parsecs >> initializeWith: aDistance [

	distance := aDistance
]

{ #category : #validation }
Parsecs >> isValid [
	^ distance >=0.
]
