Class {
	#name : #RandomDie,
	#superclass : #Object,
	#instVars : [
		'numberOfSides'
	],
	#classVars : [
		'NumberOfSides'
	],
	#category : #'Zathura-Model'
}

{ #category : #asserting }
RandomDie class >> assertValid: aNumberOfSides [

	aNumberOfSides > 2 ifFalse: [ 
		Error signal: 'Die cannot be created with a number of sides lower than 3' ]
]

{ #category : #initialization }
RandomDie class >> with: aNumberOfSides [
	self assertValid: aNumberOfSides.
	^ self new initializeWith: aNumberOfSides 
]

{ #category : #initialization }
RandomDie >> initializeWith: aNumberOfSides [
	numberOfSides := aNumberOfSides 
]

{ #category : #validations }
RandomDie >> isValid [
	^(numberOfSides > 2)
]

{ #category : #dieRolling }
RandomDie >> roll [
	^ numberOfSides atRandom.
]
