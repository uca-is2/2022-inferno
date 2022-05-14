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

{ #category : #accessing }
Board >> effectAt: slotPosition [ 
	((layout at: 'speedUps') includes: slotPosition) ifTrue: [ ^ 'speedUps'].
	((layout at: 'wormholes') includes: slotPosition) ifTrue: [ ^ 'wormholes'].
	((layout at: 'moonWalks') includes: slotPosition) ifTrue: [ ^ 'moonWalks'].
	((layout at: 'hyperJumps') includes: slotPosition) ifTrue: [ ^ 'hyperJumps'].
	((layout at: 'atomicBombs') includes: slotPosition) ifTrue: [ ^ 'atomicBombs'].
	^'noEffect'.
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfSlots [

	| numberOfSpeedUps numberOfWormholes numberOfMoonwalks numberOfHyperJumps numberOfAtomicBombs effectsPositions i randomSlot|
	numberOfSlots := aNumberOfSlots.
	numberOfSpeedUps := (numberOfSlots * 0.2)asInteger.
	numberOfWormholes := (numberOfSlots * 0.2)asInteger.
	numberOfMoonwalks := (numberOfSlots * 0.1)asInteger.
	numberOfHyperJumps := (numberOfSlots * 0.08)asInteger.
	numberOfAtomicBombs := (numberOfSlots * 0.02)asInteger.

	layout := Dictionary new.
	i := 0.
	
	effectsPositions := Array new: numberOfSpeedUps.
	[ i < numberOfSpeedUps] whileTrue: [
		randomSlot := numberOfSlots atRandom. 
		(effectsPositions includes: randomSlot ) ifFalse: [ 
			effectsPositions at: (i+1) put: randomSlot.
			i := i+1.
			 ].
	 ].
	layout at: 'speedUps' put: effectsPositions.
	
	i := 0.
	effectsPositions := Array new: numberOfWormholes.
	[ i < numberOfWormholes] whileTrue: [
		randomSlot := numberOfSlots atRandom. 
		((effectsPositions includes: randomSlot) | ((layout at: 'speedUps') includes: randomSlot )) ifFalse: [ 
			effectsPositions at: (i+1) put: randomSlot.
			i := i+1.
			 ].
	 ].
	layout at: 'wormholes' put: effectsPositions.
	
	i := 0.
	effectsPositions := Array new: numberOfMoonwalks.
	[ i < numberOfMoonwalks] whileTrue: [
		randomSlot := numberOfSlots atRandom. 
		((effectsPositions includes: randomSlot) | ((layout at: 'speedUps') includes: randomSlot) | ((layout at: 'wormholes') includes: randomSlot) ) ifFalse: [ 
			effectsPositions at: (i+1) put: randomSlot.
			i := i+1.
			 ].
	 ].
	layout at: 'moonWalks' put: effectsPositions.


	i := 0.
	effectsPositions := Array new: numberOfHyperJumps.
	[ i < numberOfHyperJumps] whileTrue: [
		randomSlot := numberOfSlots atRandom. 
		((effectsPositions includes: randomSlot) | ((layout at: 'speedUps') includes: randomSlot) | ((layout at: 'wormholes') includes: randomSlot) |((layout at: 'moonWalks') includes: randomSlot)) ifFalse: [ 
			effectsPositions at: (i+1) put: randomSlot.
			i := i+1.
			].
	 ].
	layout at: 'hyperJumps' put: effectsPositions.

	i := 0.
   effectsPositions := Array new: numberOfAtomicBombs.
   [ i < numberOfAtomicBombs] whileTrue: [
            randomSlot := numberOfSlots atRandom. 
            ((effectsPositions includes: randomSlot) | ((layout at: 'speedUps') includes: randomSlot) | ((layout at: 'wormholes') includes: randomSlot) | ((layout at: 'moonWalks') includes: randomSlot) | ((layout at: 'hyperJumps') includes: randomSlot)) ifFalse: [ 
                effectsPositions at: (i+1) put: randomSlot.
                i := i+1.
                ].
        ].
      layout at: 'atomicBombs' put: effectsPositions.
	
		effectsPositions := Array new: (numberOfSlots - numberOfSpeedUps - numberOfWormholes - numberOfMoonwalks - numberOfHyperJumps - numberOfAtomicBombs).
		1 to: numberOfSlots do: [ :slotNumber |
		(((layout at: 'atomicBombs') includes: slotNumber ) | ((layout at: 'speedUps') includes: slotNumber ) | ((layout at: 'wormholes') includes: slotNumber) | ((layout at: 'moonWalks') includes: slotNumber ) | ((layout at: 'hyperJumps') includes: slotNumber )) ifFalse: [ 
                effectsPositions at: (i+1) put: slotNumber .
                ].
		].
		layout at: 'noEffect' put: effectsPositions.
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
