"
i represent a board that contains a series of spots.
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'layout',
		'parsecs',
		'numberOfSpots'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> with: aNumberOfSpots withALengthOf: anAmountOfParsecs [ 
	(aNumberOfSpots > 0) ifFalse: [ 
		Error signal:
			'Board cannot be created with a number of slots lower than 1 ' ].
	(anAmountOfParsecs >= aNumberOfSpots) ifFalse:[ 
		Error signal:
			'Board cannot be created with a number of parsecs lower than the amount of spots' ].
	
	^ self new initializeWith: aNumberOfSpots andNumberOfParsecs: anAmountOfParsecs. 
]

{ #category : #initialization }
Board >> effectLoader: arrayOfEffects with: aNumberOfSpots [ 

	| arrayOfUsedSpots spotsWithThisEffect randomSlot arrayOfSpots |
	spotsWithThisEffect := 0.
	arrayOfUsedSpots := OrderedCollection new: aNumberOfSpots.
	arrayOfSpots := Array new: aNumberOfSpots.
	1 to: (arrayOfEffects size) do: [:effect|  
		[((arrayOfEffects at: effect) size) > spotsWithThisEffect ]whileTrue: [ 
			randomSlot := aNumberOfSpots atRandom. 
			(arrayOfUsedSpots includes: randomSlot )ifFalse: [  
			arrayOfUsedSpots addLast: randomSlot.
			arrayOfSpots at: randomSlot put: ((arrayOfEffects at: effect) at: spotsWithThisEffect+1).
			spotsWithThisEffect := spotsWithThisEffect+1 ].
		].
		spotsWithThisEffect := 0.
	]. 	 
	(arrayOfSpots includes: nil)ifTrue: [ arrayOfSpots := self llenaLosNils: arrayOfSpots ofSize: (arrayOfEffects size)].
	^ arrayOfSpots 
]

{ #category : #initialization }
Board >> fillWithEffects: aNumberOfSpots [
	| arrayOfSpots |
	arrayOfSpots := Array new: aNumberOfSpots.
	arrayOfSpots := self loadEffects: aNumberOfSpots.
	^ arrayOfSpots
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfSpots andNumberOfParsecs: aLenghtInParsecs [ 
	layout := Array new: aNumberOfSpots.
	layout := self fillWithEffects: aNumberOfSpots.	
	parsecs := aLenghtInParsecs.
	numberOfSpots := aNumberOfSpots.
]

{ #category : #getters }
Board >> layout [
	^ layout
]

{ #category : #getters }
Board >> lenghtInParsecs [
	^ parsecs 
]

{ #category : #getters }
Board >> length [
	^ numberOfSpots
]

{ #category : #initialization }
Board >> llenaLosNils: anArrayOfSpots ofSize: anAmountOfEffects [

	1 to: anAmountOfEffects do: [ :each | 
		(anArrayOfSpots at: each)ifNil: [ 
			anArrayOfSpots at: each put: (Spot createWith: NoEffect new) ] ].
	^ anArrayOfSpots.
]

{ #category : #initialization }
Board >> loadAtomicBomb: aNumberOfSpots [
	| numberOfAtomicBomb arrayOfAtomicBomb |
	numberOfAtomicBomb := (aNumberOfSpots  * 0.02)asInteger.
	arrayOfAtomicBomb := Array new: numberOfAtomicBomb.
	arrayOfAtomicBomb := arrayOfAtomicBomb collect: [:each| Spot createWith: AtomicBomb new.].
	^ arrayOfAtomicBomb 
]

{ #category : #initialization }
Board >> loadEffects: aNumberOfSpots [ 
	
	| arrayOfNoEffect arrayOfEffects arrayOfSpots arrayOfSpeedUp arrayOfMoonwalk arrayOfWormhole arrayOfAtomicBomb arrayOfHyperJump |
	arrayOfSpots := Array new: aNumberOfSpots.
	arrayOfSpeedUp := self loadSpeedUps: aNumberOfSpots.
	arrayOfMoonwalk := self loadMoonwalk: aNumberOfSpots.
	arrayOfWormhole := self loadWormhole: aNumberOfSpots.
	arrayOfAtomicBomb := self loadAtomicBomb: aNumberOfSpots.
	arrayOfHyperJump := self loadHyperjump: aNumberOfSpots.
	arrayOfNoEffect := self loadNoEffect: aNumberOfSpots .
	arrayOfEffects := [ arrayOfSpeedUp, arrayOfMoonwalk , arrayOfWormhole , arrayOfAtomicBomb , arrayOfHyperJump , arrayOfNoEffect].
	arrayOfSpots := self effectLoader: arrayOfEffects with: aNumberOfSpots .
	 
	^ arrayOfSpots
	
]

{ #category : #initialization }
Board >> loadHyperjump: aNumberOfSpots [ 

	| numberOfHyperjump arrayOfHyperJump |
	numberOfHyperjump := (aNumberOfSpots  * 0.08)asInteger.
	arrayOfHyperJump := Array new: numberOfHyperjump.
	arrayOfHyperJump := arrayOfHyperJump collect: [:each| Spot createWith: Hyperjump new.].
	^ arrayOfHyperJump 	
]

{ #category : #initialization }
Board >> loadMoonwalk: aNumberOfSpots [ 
	| numberOfMoonwalk arrayOfMoonwalk |
	numberOfMoonwalk := (aNumberOfSpots  * 0.1)asInteger.
	arrayOfMoonwalk := Array new: numberOfMoonwalk.
	arrayOfMoonwalk := arrayOfMoonwalk collect: [:each| Spot createWith: Moonwalk new.].
	^ arrayOfMoonwalk 
]

{ #category : #initialization }
Board >> loadNoEffect: aNumberOfSpots [
	| numberOfNoEffect arrayOfNoEffect |
	numberOfNoEffect := (aNumberOfSpots  * 0.4)asInteger.
	arrayOfNoEffect := Array new: numberOfNoEffect.
	arrayOfNoEffect := arrayOfNoEffect collect: [:each| Spot createWith: NoEffect new.].
	^ arrayOfNoEffect 
]

{ #category : #initialization }
Board >> loadSpeedUps: aNumberOfSpots [

	| numberOfSpeedUps arrayOfSpeedUp |
	numberOfSpeedUps := (aNumberOfSpots  * 0.2)asInteger.
	arrayOfSpeedUp := Array new: numberOfSpeedUps.
	arrayOfSpeedUp := arrayOfSpeedUp collect: [:each| Spot createWith: SpeedUp new.].
	^ arrayOfSpeedUp 
]

{ #category : #initialization }
Board >> loadWormhole: aNumberOfSpots [ 

	| numberOfWormholes arrayOfWormholes |
	numberOfWormholes := (aNumberOfSpots  * 0.2)asInteger.
	arrayOfWormholes := Array new: numberOfWormholes.
	arrayOfWormholes := arrayOfWormholes collect: [:each| Spot createWith: Wormhole new.].
	^ arrayOfWormholes 
]
