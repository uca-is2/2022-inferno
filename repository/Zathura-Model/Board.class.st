Class {
	#name : #Board,
	#superclass : #Object,
	#classVars : [
		'NumberOfSlots'
	],
	#category : #'Zathura-Model'
}

{ #category : #'as yet unclassified' }
Board class >> checkIsMoreThanThree: aNumberOfSlots [
	aNumberOfSlots > 3 ifFalse: [ 
		Error signal: 'Minimun length should be more than three' ]

	
]

{ #category : #validation }
Board class >> isValid [
	^(NumberOfSlots  > 3).
]

{ #category : #validation }
Board class >> isValid: aMinimunLength [
	^(NumberOfSlots > aMinimunLength ).
]

{ #category : #'instance creation' }
Board class >> with: aNumberOfSlots [

	self checkIsMoreThanThree: aNumberOfSlots.
	
	^ self new initializeWith: aNumberOfSlots.
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfSlots [ 
	NumberOfSlots := aNumberOfSlots.
]

{ #category : #testing }
Board >> isValid [
	^(NumberOfSlots > 3).
]

{ #category : #testing }
Board >> isValid: aMinimunNumberOfSlots [ 
	^(NumberOfSlots > aMinimunNumberOfSlots  ).
]
