"
i represent a type of effect: hyperjump
"
Class {
	#name : #Hyperjump,
	#superclass : #Object,
	#instVars : [
		'jumpsArray'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Hyperjump class >> createWith: aJumpsArray [ 
	1 to: aJumpsArray size do: [:each |  
		(aJumpsArray at: each) >= 0 ifFalse: [ 
		Error signal:
			'Hyperjump number cant be a negative number.' ].
		].
		^self new initializeWith: aJumpsArray.
]

{ #category : #applying }
Hyperjump >> applyTo: aBoard by: aSpaceship [ 
	self shouldBeImplemented.
]

{ #category : #initialization }
Hyperjump >> initializeWith: aJumpsArray [ 
	| sortedArray reversedArray |
	sortedArray := aJumpsArray sorted.
	reversedArray := sortedArray reversed.
	jumpsArray := aJumpsArray .
]
