"
i represent an effect filler. an object that fills effects randomly
"
Class {
	#name : #EffectFiller,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #amountGetters }
EffectFiller >> amountOfAtomicBombsForThisSize: anAmountOfSpots [

	^ (anAmountOfSpots * 0.02) asInteger
]

{ #category : #amountGetters }
EffectFiller >> amountOfEveryOtherEffect: anAmountOfSpots [ 
	| sum |
	sum := (self amountOfAtomicBombsForThisSize: anAmountOfSpots) +( self amountOfHyperJumpsForThisSize: anAmountOfSpots) + (self amountOfMoonwalkForThisSize: anAmountOfSpots) + (self amountOfWormholesForThisSize: anAmountOfSpots) + (self amountOfSpeedUpsForThisSize: anAmountOfSpots).
	^sum.
]

{ #category : #amountGetters }
EffectFiller >> amountOfHyperJumpsForThisSize: anAmountOfSpots [

	^ (anAmountOfSpots * 0.08) asInteger
]

{ #category : #amountGetters }
EffectFiller >> amountOfMoonwalkForThisSize: anAmountOfSpots [

	^ (anAmountOfSpots * 0.1) asInteger
]

{ #category : #amountGetters }
EffectFiller >> amountOfNoEffectsForThisSize: anAmountOfSpots [ 
	| amountOfNoEffects | 
	amountOfNoEffects := (anAmountOfSpots - (self amountOfEveryOtherEffect: anAmountOfSpots) ).
	^ amountOfNoEffects .
]

{ #category : #amountGetters }
EffectFiller >> amountOfSpeedUpsForThisSize: anAmountOfSpots [ 
	^ (anAmountOfSpots * 0.2) asInteger
]

{ #category : #amountGetters }
EffectFiller >> amountOfWormholesForThisSize: anAmountOfSpots [

	^ (anAmountOfSpots * 0.2) asInteger
]

{ #category : #validation }
EffectFiller >> assertValid: aCollectionOfJumpArrays with: amountOfHyperjumps [

	aCollectionOfJumpArrays size == amountOfHyperjumps ifFalse: [ 
		Error signal:
			'Number of HyperJumps array must be equal to the amount of hyperjumps needed.' ]
]

{ #category : #validation }
EffectFiller >> assertValid: aCollectionOfMoonwalkNumbers withAmount: amountOfMoonwalks [

	aCollectionOfMoonwalkNumbers size == amountOfMoonwalks ifFalse: [ 
		Error signal:
			'Number of Moonwalks numbers must be equal to the amount of moonwalks needed.' ]
]

{ #category : #effectFilling }
EffectFiller >> fillWithEffects: aNumberOfSpots with: aCollectionOfJumpArrays and: aCollectionOfMoonwalkNumbers [
	
	| arrayOfNoEffect arrayOfEffects arrayOfSpots arrayOfSpeedUp arrayOfMoonwalk arrayOfWormhole arrayOfAtomicBomb arrayOfHyperJump |
	arrayOfSpots := Array new: aNumberOfSpots.
	arrayOfSpeedUp := self loadSpeedUps: aNumberOfSpots.
	arrayOfMoonwalk := self loadMoonwalk: aNumberOfSpots with: aCollectionOfMoonwalkNumbers.
	arrayOfWormhole := self loadWormhole: aNumberOfSpots.
	arrayOfAtomicBomb := self loadAtomicBomb: aNumberOfSpots.
	arrayOfHyperJump := self loadHyperjump: aNumberOfSpots with: aCollectionOfJumpArrays.
	arrayOfNoEffect := self loadNoEffect: aNumberOfSpots .
	arrayOfEffects := [ arrayOfSpeedUp, arrayOfMoonwalk , arrayOfWormhole , arrayOfAtomicBomb , arrayOfHyperJump , arrayOfNoEffect].
	arrayOfSpots := self effectLoader: arrayOfEffects with: aNumberOfSpots .
	^ arrayOfSpots
	
]

{ #category : #creation }
EffectFiller >> for: anAmountOfSpots with: aCollectionOfJumpArrays and: aCollectionOfMoonwalkNumbers [

	| amountOfHyperjumps  amountOfMoonwalks  loadedLayout |
	amountOfHyperjumps := self amountOfHyperJumpsForThisSize: anAmountOfSpots.
	amountOfMoonwalks := self amountOfMoonwalkForThisSize: anAmountOfSpots.
	self assertValid: aCollectionOfJumpArrays with: amountOfHyperjumps.
	self assertValid: aCollectionOfMoonwalkNumbers withAmount: amountOfMoonwalks.
		
	loadedLayout := self fillWithEffects: anAmountOfSpots with: aCollectionOfJumpArrays and: aCollectionOfMoonwalkNumbers.
	^ loadedLayout
]

{ #category : #effectLoading }
EffectFiller >> loadAtomicBomb: anAmountOfSpots [
	| numberOfAtomicBomb arrayOfAtomicBomb |
	numberOfAtomicBomb := self amountOfAtomicBombsForThisSize: anAmountOfSpots.
	arrayOfAtomicBomb := Array new: numberOfAtomicBomb.
	arrayOfAtomicBomb := arrayOfAtomicBomb collect: [:each| Spot createWith: AtomicBomb new.].
	^ arrayOfAtomicBomb 
]

{ #category : #effectLoading }
EffectFiller >> loadHyperjump: anInteger [ 
	self shouldBeImplemented.
]

{ #category : #effectLoading }
EffectFiller >> loadHyperjump: anAmountOfSpots with: aCollectionOfJumpArrays [ 
	| numberOfHyperJumps arrayOfHyperjump |
	numberOfHyperJumps := self amountOfHyperJumpsForThisSize: anAmountOfSpots.
	arrayOfHyperjump := Array new: numberOfHyperJumps.	
	1 to: numberOfHyperJumps do: [:each | arrayOfHyperjump at: each put: (Spot createWith: (Hyperjump createWith: (aCollectionOfJumpArrays at: each)))].
	^ arrayOfHyperjump 
]

{ #category : #effectLoading }
EffectFiller >> loadMoonwalk: anAmountOfSpots with: aCollectionOfMoonwalkNumbers [ 
	| numberOfMoonwalk arrayOfMoonwalk |
	numberOfMoonwalk := self amountOfMoonwalkForThisSize: anAmountOfSpots.
	arrayOfMoonwalk := Array new: numberOfMoonwalk.	
	1 to: numberOfMoonwalk do: [:each | arrayOfMoonwalk at: each put: (Spot createWith: (Moonwalk createWith: (aCollectionOfMoonwalkNumbers at: each)))].
	^ arrayOfMoonwalk 
]

{ #category : #effectLoading }
EffectFiller >> loadNoEffect: anAmountOfSpots [ 
	| numberOfNoEffect arrayOfNoEffect |
	numberOfNoEffect := self amountOfNoEffectsForThisSize: anAmountOfSpots.
	arrayOfNoEffect := Array new: numberOfNoEffect.
	arrayOfNoEffect := arrayOfNoEffect collect: [:each| Spot createWith: NoEffect new.].
	^ arrayOfNoEffect 
]

{ #category : #effectLoading }
EffectFiller >> loadSpeedUps: anAmountOfSpots [ 
	| numberOfSpeedUps arrayOfSpeedUp |
	numberOfSpeedUps := self amountOfSpeedUpsForThisSize: anAmountOfSpots.
	arrayOfSpeedUp := Array new: numberOfSpeedUps.
	arrayOfSpeedUp := arrayOfSpeedUp collect: [:each| Spot createWith: SpeedUp new.].
	^ arrayOfSpeedUp 
]

{ #category : #effectLoading }
EffectFiller >> loadWormhole: anAmountOfSpots [

	| numberOfWormholes arrayOfWormholes |
	numberOfWormholes := self amountOfWormholesForThisSize: anAmountOfSpots.
	arrayOfWormholes := Array new: numberOfWormholes.
	arrayOfWormholes := arrayOfWormholes collect: [:each| Spot createWith: Wormhole new.].
	^ arrayOfWormholes 
]
