"
Represents a Cup with different Dice
"
Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
DiceCup class >> with: aCollectionOfDice [

	^ self new initializeWith: aCollectionOfDice
]

{ #category : #initialization }
DiceCup >> initializeWith: aCollectionOfDice [

	dice := aCollectionOfDice
]

{ #category : #diceCupRolling }
DiceCup >> roll [

	^ dice sum: [ :die | die roll ]
]
