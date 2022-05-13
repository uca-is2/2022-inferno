"
I represent a Board of slots to be played with.

"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfSlots',
		'layout'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> with: aNumberOfSlots [

	aNumberOfSlots > 0 ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of slots lower than 1' ].
	^ self new initializeWith: aNumberOfSlots
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfSlots [

	| numberOfSpeedUps numberOfWormholes numberOfMoonwalks numberOfHyperJumps numberOfAtomicBombs |
	numberOfSlots := aNumberOfSlots.
	numberOfSpeedUps := (numberOfSlots * 0.2)integerPart.
	numberOfWormholes := (numberOfSlots * 0.2)integerPart.
	numberOfMoonwalks := (numberOfSlots * 0.1)integerPart.
	numberOfHyperJumps := (numberOfSlots * 0.08)integerPart.
	numberOfAtomicBombs := (numberOfSlots * 0.02)integerPart.
	"Aca crea el layout con todos los slots en 'no effect' "
	layout := Dictionary new.
	1 to: numberOfSlots do: [ :slotNumber |
		layout at: slotNumber put: 'noEffect'].
	"Ahora asigno randomly segun la proporcion dada"
	(numberOfSpeedUps > 0) whileTrue: [ 
		layout at: numberOfSlots atRandom put: 'speedUp'].
	(numberOfWormholes  > 0) whileTrue: [ 
		layout at: numberOfSlots atRandom put: 'wormHole'].
	(numberOfMoonwalks  > 0) whileTrue: [ 
		layout at: numberOfSlots atRandom put: 'moonWalk'].
	(numberOfHyperJumps  > 0) whileTrue: [ 
		layout at: numberOfSlots atRandom put: 'hyperJumps'].
	(numberOfAtomicBombs  > 0) whileTrue: [ 
		layout at: numberOfSlots atRandom put: 'atomicBomb'].
]

{ #category : #validation }
Board >> isValid [

	^ numberOfSlots > 0
]

{ #category : #accessing }
Board >> layout [

	^ layout
]

{ #category : #'accessing - attributes' }
Board >> lenght [

	^ numberOfSlots
]
