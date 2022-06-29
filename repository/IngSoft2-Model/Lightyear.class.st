Class {
	#name : #Lightyear,
	#superclass : #Distance,
	#instVars : [
		'distance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Lightyear class >> with: aDistance [

	^ self new initializeWith: aDistance
]

{ #category : #accesing }
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
