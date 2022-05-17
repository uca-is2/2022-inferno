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
Board >> amountOfSlotsToMoveInMoonwalk: positionOfMoonwalk [

	^ (layout at: 'moonWalks' at: 2) at: positionOfMoonwalk
]

{ #category : #accessing }
Board >> effectAt: slotPosition [

	((layout at: 'speedUps') includes: slotPosition) ifTrue: [ 
		^ 'speedUps' ].
	((layout at: 'wormholes') includes: slotPosition) ifTrue: [ 
		^ 'wormholes' ].
	((layout at: 'moonWalks') includes: slotPosition) ifTrue: [ 
		^ 'moonWalks' ].
	((layout at: 'hyperJumps') includes: slotPosition) ifTrue: [ 
		^ 'hyperJumps' ].
	((layout at: 'atomicBombs') includes: slotPosition) ifTrue: [ 
		^ 'atomicBombs' ].
	^ 'noEffect'
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

	| numberOfSpeedUps numberOfWormholes numberOfMoonwalks numberOfHyperJumps numberOfAtomicBombs effectsPositions slotsWithThisEffect randomSlot minValueHyperJump maxValueHyperJump moonWalkValues moonwalksPositionsAndValues |
	numberOfSlots := aNumberOfSlots.
	numberOfParsecs := amountOfParsecs.
	numberOfSpeedUps := self percentageOfSlots: 0.2.
	numberOfWormholes := self percentageOfSlots: 0.2.
	numberOfMoonwalks := self percentageOfSlots: 0.1.
	numberOfHyperJumps := self percentageOfSlots: 0.08.
	numberOfAtomicBombs := self percentageOfSlots: 0.02.
	layout := Dictionary new.
	slotsWithThisEffect := 0.
	effectsPositions := Array new: numberOfSpeedUps.
	[ slotsWithThisEffect < numberOfSpeedUps ] whileTrue: [ 
		randomSlot := numberOfSlots atRandom.
		(effectsPositions includes: randomSlot) ifFalse: [ 
			effectsPositions at: slotsWithThisEffect + 1 put: randomSlot.
			slotsWithThisEffect := slotsWithThisEffect + 1 ] ].
	layout at: 'speedUps' put: effectsPositions.

	slotsWithThisEffect := 0.
	effectsPositions := Array new: numberOfWormholes.
	[ slotsWithThisEffect < numberOfWormholes ] whileTrue: [ 
		randomSlot := numberOfSlots atRandom.
		(effectsPositions includes: randomSlot)
		| (self slotAlreadyHasEffect: randomSlot) ifFalse: [ 
			effectsPositions at: slotsWithThisEffect + 1 put: randomSlot.
			slotsWithThisEffect := slotsWithThisEffect + 1 ] ].
	layout at: 'wormholes' put: effectsPositions.

	slotsWithThisEffect := 0.
	effectsPositions := Array new: numberOfMoonwalks.
	moonWalkValues := Array new: numberOfMoonwalks.
	[ slotsWithThisEffect < numberOfMoonwalks ] whileTrue: [ 
		randomSlot := numberOfSlots atRandom.
		(effectsPositions includes: randomSlot)
		| (self slotAlreadyHasEffect: randomSlot) ifFalse: [ 
			effectsPositions at: slotsWithThisEffect + 1 put: randomSlot.
			moonWalkValues
				at: slotsWithThisEffect + 1
				put: (numberOfSlots / 10) asInteger atRandom.
			slotsWithThisEffect := slotsWithThisEffect + 1 ] ].
	moonwalksPositionsAndValues := Array new: 2.
	moonwalksPositionsAndValues at: 1 put: effectsPositions.
	moonwalksPositionsAndValues at: 2 put: moonWalkValues.
	layout at: 'moonWalks' put: moonwalksPositionsAndValues.

	slotsWithThisEffect := 0.
	effectsPositions := Array new: numberOfHyperJumps.
	[ slotsWithThisEffect < numberOfHyperJumps ] whileTrue: [ 
		randomSlot := numberOfSlots atRandom.
		(effectsPositions includes: randomSlot)
		| (self slotAlreadyHasEffect: randomSlot) ifFalse: [ 
			effectsPositions at: slotsWithThisEffect + 1 put: randomSlot.
			slotsWithThisEffect := slotsWithThisEffect + 1 ] ].
	layout at: 'hyperJumps' put: effectsPositions.

	slotsWithThisEffect := 0.
	effectsPositions := Array new: numberOfAtomicBombs.
	[ slotsWithThisEffect < numberOfAtomicBombs ] whileTrue: [ 
		randomSlot := numberOfSlots atRandom.
		((effectsPositions includes: randomSlot) | self 
			 slotAlreadyHasEffect: randomSlot) ifFalse: [ 
			effectsPositions at: slotsWithThisEffect + 1 put: randomSlot.
			slotsWithThisEffect := slotsWithThisEffect + 1 ] ].
	layout at: 'atomicBombs' put: effectsPositions.

	effectsPositions := Array new:
		                    numberOfSlots - numberOfSpeedUps
		                    - numberOfWormholes - numberOfMoonwalks
		                    - numberOfHyperJumps - numberOfAtomicBombs.
	slotsWithThisEffect := 0.
	1 to: numberOfSlots do: [ :slotNumber | 
		(self slotAlreadyHasEffect: randomSlot) ifFalse: [ 
			effectsPositions at: slotsWithThisEffect + 1 put: slotNumber.
			slotsWithThisEffect := slotsWithThisEffect + 1 ] ].
	layout at: 'noEffect' put: effectsPositions.

	numberOfParsecs := amountOfParsecs.
	hyperJumpValues := OrderedCollection new: 10.
	minValueHyperJump := 0.
	maxValueHyperJump := amountOfParsecs - 10.
	1 to: 10 do: [ :z | 
		hyperJumpValues addFirst:
			(minValueHyperJump to: maxValueHyperJump + z) atRandom.
		minValueHyperJump := hyperJumpValues first ]
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
Board >> moonwalkSlotActivated: spaceshipPosition [

	^ (layout at: 'moonWalks' at: 1) indexOf: spaceshipPosition
]

{ #category : #initialize }
Board >> percentageOfSlots: percentage [ 
	^ (numberOfSlots * percentage)asInteger
]

{ #category : #'accessing - attributes' }
Board >> slotAlreadyHasEffect: slot [ 
	| slotHasEffect |
	slotHasEffect := false.
	(((layout  at: 'speedUps' ifAbsent: [ #[] ]) includes:slot) | ((layout  at: 'wormholes' ifAbsent: [ #[] ]) includes:slot) | ((layout  at: 'moonWalks' at:1 ifAbsent: [ #[] ]) includes:slot) | ((layout  at: 'hyperJumps' ifAbsent: [ #[] ]) includes:slot) | ((layout  at: 'atomicBombs' ifAbsent: [ #[] ]) includes:slot) ) ifTrue: [ 
		slotHasEffect := true
		 ].
	^ slotHasEffect.
]

{ #category : #accessing }
Board >> slotsForMoonwalk: spaceshipPosition [

	| positionOfMoonwalk |
	positionOfMoonwalk := self moonwalkSlotActivated: spaceshipPosition.
	^ self amountOfSlotsToMoveInMoonwalk: positionOfMoonwalk.
]
