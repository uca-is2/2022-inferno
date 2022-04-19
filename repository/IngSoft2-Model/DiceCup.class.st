"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
!
For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	dice:		<Object>


    Implementation Points
"
Class {
	#name : #DiceCup,
	#superclass : #Object,
	#classVars : [
		'Dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
DiceCup class >> isValid [
	| validation |
	validation := true.
	1 to: (Dice size) do: [:i | ((Dice at: i) isValid) ifFalse: [validation := false]].   
	^validation.
]

{ #category : #initialization }
DiceCup class >> witAll: aNumberOfSides [
	|aDice|
	aDice := Array new: (aNumberOfSides size).
	1 to: (aNumberOfSides size) do: [ :i |aDice at: i put:(RandomDie with: (aNumberOfSides at: i)) ].
	 ^self new initializeWithAll: aDice.
	
]

{ #category : #'as yet unclassified' }
DiceCup class >> witAllLoaded: aNumberOfLoadedSides [
	|aLoadedDice|
	aLoadedDice := Array new: (aNumberOfLoadedSides size).
	1 to: (aNumberOfLoadedSides size) do: [ :i |aLoadedDice at: i put:(LoadedDie with: (aNumberOfLoadedSides at: i)) ].
	 ^self new initializeWithAll: aLoadedDice.
]

{ #category : #initialization }
DiceCup >> initializeWithAll: aDice [ 
	Dice := aDice.
]

{ #category : #testing }
DiceCup >> isValid [
	| validation |
	validation := true.
	1 to: (Dice size) do: [:i | ((Dice at: i) isValid) ifFalse: [validation := false]].   
	^validation.
]

{ #category : #rolling }
DiceCup >> roll [
	| result |
	
	result := 0.
	Dice do: [ :aDie  | result := result  + aDie roll].
	^ result.
]
