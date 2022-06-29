Class {
	#name : #Parsecs,
	#superclass : #Distance,
	#instVars : [
		'distance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance cre' }
Parsecs class >> with: aTotalDistance [

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
