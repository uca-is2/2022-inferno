"
I represent a Board of slots to be played with.

"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfSlots',
		'layout',
		'numberOfParsecs',
		'hyperJumpValues'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> with: aNumberOfSlots andNumberOfParsecs: amountOfParsecs [

	((aNumberOfSlots > 0) & (amountOfParsecs > 9)) ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of slots lower than 1 or Parsecs lower than 9' ].
	^ self new initializeWith: aNumberOfSlots andNumberOfParsecs: amountOfParsecs
]

{ #category : #'instance creation' }
Board class >> withCustomLayout: aLayout andNumberOfSlots: aNumberOfSlots [

	^ self new initializeWithCustomLayout: aLayout and: aNumberOfSlots.
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

{ #category : #accessing }
Board >> hyperJumpDistanceInSlots [
	| parsecsForThisJump slotsInThisHyperJump|
	parsecsForThisJump := hyperJumpValues removeFirst.
	hyperJumpValues addLast: parsecsForThisJump .
	slotsInThisHyperJump := (parsecsForThisJump /(numberOfParsecs/numberOfSlots))asInteger.
	^slotsInThisHyperJump.
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfSlots andNumberOfParsecs: amountOfParsecs [

	| numberOfSpeedUps numberOfWormholes numberOfMoonwalks numberOfHyperJumps numberOfAtomicBombs effectsPositions i randomSlot minValueHyperJump maxValueHyperJump moonWalkValues moonwalksPositionsAndValues |
	numberOfSlots := aNumberOfSlots.
	numberOfParsecs := amountOfParsecs.
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
	moonWalkValues := Array new: numberOfMoonwalks.
	[ i < numberOfMoonwalks] whileTrue: [
		randomSlot := numberOfSlots atRandom. 
		((effectsPositions includes: randomSlot) | ((layout at: 'speedUps') includes: randomSlot) | ((layout at: 'wormholes') includes: randomSlot) ) ifFalse: [ 
			effectsPositions at: (i+1) put: randomSlot.
			moonWalkValues at: (i+1) put: ((numberOfSlots/10) asInteger) atRandom.
			i := i+1.
			 ].
	 ].
	moonwalksPositionsAndValues := Array new:2.
	moonwalksPositionsAndValues at: 1 put: effectsPositions.
	moonwalksPositionsAndValues at: 2 put: moonWalkValues.
	layout at: 'moonWalks'  put: moonwalksPositionsAndValues.  

	i := 0.
	effectsPositions := Array new: numberOfHyperJumps.
	[ i < numberOfHyperJumps] whileTrue: [
		randomSlot := numberOfSlots atRandom. 
		((effectsPositions includes: randomSlot) | ((layout at: 'speedUps') includes: randomSlot) | ((layout at: 'wormholes') includes: randomSlot) |((layout at: 'moonWalks' at:1) includes: randomSlot)) ifFalse: [ 
			effectsPositions at: (i+1) put: randomSlot.
			i := i+1.
			].
	 ].
	layout at: 'hyperJumps' put: effectsPositions.

	i := 0.
   effectsPositions := Array new: numberOfAtomicBombs.
   [ i < numberOfAtomicBombs] whileTrue: [
            randomSlot := numberOfSlots atRandom. 
            ((effectsPositions includes: randomSlot) | ((layout at: 'speedUps') includes: randomSlot) | ((layout at: 'wormholes') includes: randomSlot) | ((layout at: 'moonWalks' at:1) includes: randomSlot) | ((layout at: 'hyperJumps') includes: randomSlot)) ifFalse: [ 
                effectsPositions at: (i+1) put: randomSlot.
                i := i+1.
                ].
        ].
      layout at: 'atomicBombs' put: effectsPositions.
	
		effectsPositions := Array new: (numberOfSlots - numberOfSpeedUps - numberOfWormholes - numberOfMoonwalks - numberOfHyperJumps - numberOfAtomicBombs).
		1 to: numberOfSlots do: [ :slotNumber |
		(((layout at: 'atomicBombs') includes: slotNumber ) | ((layout at: 'speedUps') includes: slotNumber ) | ((layout at: 'wormholes') includes: slotNumber) | ((layout at: 'moonWalks' at:1) includes: slotNumber ) | ((layout at: 'hyperJumps') includes: slotNumber )) ifFalse: [ 
                effectsPositions at: (i+1) put: slotNumber .
                ].
		].
		layout at: 'noEffect' put: effectsPositions.
		
		numberOfParsecs := amountOfParsecs.
		hyperJumpValues := OrderedCollection new: 10.
		minValueHyperJump := 0.
		maxValueHyperJump := (amountOfParsecs - 10).
		1 to: 10 do: [ :z |
			hyperJumpValues addFirst: ((minValueHyperJump to: maxValueHyperJump) atRandom).
			minValueHyperJump := hyperJumpValues first.
			maxValueHyperJump := (maxValueHyperJump + 1)
			 ]
]

{ #category : #'class initialization' }
Board >> initializeWithCustomLayout: aCustomLayout and: aNumberOfSlots [
	layout := aCustomLayout .
	numberOfSlots := aNumberOfSlots.
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

{ #category : #accessing }
Board >> slotsForMoonwalk: spaceshipPosition [

| positionOfMoonwalk slotsToMoveInMoonwalk |
positionOfMoonwalk := (layout at: 'moonWalks' at: 1) indexOf: spaceshipPosition.
slotsToMoveInMoonwalk := (layout at: 'moonWalks' at: 2) at: positionOfMoonwalk.
^ slotsToMoveInMoonwalk.
]
