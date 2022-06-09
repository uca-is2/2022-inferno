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
Moonwalk class >> createWith: aMoonwalkNumber [ 
		aMoonwalkNumber >= 0 ifFalse: [ 
		Error signal:
			'Moonwalk number cant be a negative number.' ].
		^self new initializeWith: aMoonwalkNumber.
]

{ #category : #initialization }
Moonwalk >> initializeWith: aMoonwalkNumber [ 
	number:= aMoonwalkNumber.
	
]
