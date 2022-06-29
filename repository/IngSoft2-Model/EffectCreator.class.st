"
i represent an effect creator
"
Class {
	#name : #EffectCreator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #randomCreation }
EffectCreator >> arrayOfJumpsCreator [ 
	| arrayOfJumps arraySize|
	arraySize := (10 atRandom).
	arrayOfJumps := OrderedCollection new.
	arraySize timesRepeat:[
		arrayOfJumps add: (Parsec distanceOf: (15 atRandom))
		].
	^ arrayOfJumps
	
]

{ #category : #assertions }
EffectCreator >> assertAmountOfSpotsIsMoreThanZero: anAmountOfSpots [

	anAmountOfSpots > 0 ifFalse: [ 
		Error signal: 'Cannot create a layout with size zero or lower.' ]
]

{ #category : #assertions }
EffectCreator >> assertEffectProbabilityIsPositive: eachProbability [

	eachProbability > 0 ifFalse: [ 
		Error signal: 'Effect probability cannot be zero or lower.' ]
]

{ #category : #assertions }
EffectCreator >> assertSumOfProbabilitiesIsOneHundredOrLess: sumOfProbabilities [

	(sumOfProbabilities <= 100) ifFalse: [ 
		Error signal: 'Sum of probabilities exceeds 100 percent.' ]
]

{ #category : #layoutCreation }
EffectCreator >> createLayoutFor: anAmountOfSpots using: aDictionaryWithEffectsAndItsProbabilities [ 
	| boardLayout atomicBombTopLimit hyperjumpTopLimit moonwalkTopLimit speedUpTopLimit wormholeTopLimit cardPickerTopLimit noEffectTopLimit randomNumber |
	boardLayout := Array new: anAmountOfSpots.
	atomicBombTopLimit := (aDictionaryWithEffectsAndItsProbabilities at: 'AtomicBomb').
	hyperjumpTopLimit := (aDictionaryWithEffectsAndItsProbabilities at: 'Hyperjump') + atomicBombTopLimit.
	moonwalkTopLimit := (aDictionaryWithEffectsAndItsProbabilities at: 'Moonwalk') + hyperjumpTopLimit.
	speedUpTopLimit := (aDictionaryWithEffectsAndItsProbabilities at: 'SpeedUp') + moonwalkTopLimit.
	wormholeTopLimit := (aDictionaryWithEffectsAndItsProbabilities at: 'Wormhole') + speedUpTopLimit.
	cardPickerTopLimit := (aDictionaryWithEffectsAndItsProbabilities at: 'CardPicker') + wormholeTopLimit.
	noEffectTopLimit := 100.
	1 to: anAmountOfSpots do:[ :eachSpotNumber |
		randomNumber := 100 atRandom.
		(randomNumber <= atomicBombTopLimit)ifTrue:[
			boardLayout at: eachSpotNumber put: (Spot createWith: AtomicBomb new).
			].
		(randomNumber > atomicBombTopLimit and: (randomNumber <= hyperjumpTopLimit))ifTrue:[
			boardLayout at: eachSpotNumber put: (Spot createWith: (Hyperjump createWith: (self arrayOfJumpsCreator))).
			].
		(randomNumber > hyperjumpTopLimit and: (randomNumber <= moonwalkTopLimit))ifTrue:[
			boardLayout at: eachSpotNumber put: (Spot createWith: (Moonwalk createWith:(self moonwalkNumberCreator))).
			].
		(randomNumber > moonwalkTopLimit and: (randomNumber <= speedUpTopLimit))ifTrue:[
			boardLayout at: eachSpotNumber put: (Spot createWith: SpeedUp new).
			].
		(randomNumber > speedUpTopLimit and: (randomNumber <= wormholeTopLimit))ifTrue:[
			boardLayout at: eachSpotNumber put: (Spot createWith: Wormhole new).
			].
		(randomNumber > wormholeTopLimit and: (randomNumber <= cardPickerTopLimit))ifTrue:[
			boardLayout at: eachSpotNumber put: (Spot createWith: CardPicker new).
			].
		(randomNumber > cardPickerTopLimit and: (randomNumber <= noEffectTopLimit))ifTrue:[
			boardLayout at: eachSpotNumber put: (Spot createWith: NoEffect new).
			].
		].  
	^ boardLayout.
	
	
]

{ #category : #layoutCreation }
EffectCreator >> for: anAmountOfSpots with: aDictionaryWithEffectAndItsProbabilities [

	| sumOfProbabilities |
	sumOfProbabilities := 0.
	self assertAmountOfSpotsIsMoreThanZero: anAmountOfSpots.
	aDictionaryWithEffectAndItsProbabilities valuesDo: [ :eachProbability | 
		self assertEffectProbabilityIsPositive: eachProbability.
		sumOfProbabilities := sumOfProbabilities + eachProbability ].
	self assertSumOfProbabilitiesIsOneHundredOrLess: sumOfProbabilities.
	^ self
		  createLayoutFor: anAmountOfSpots
		  using: aDictionaryWithEffectAndItsProbabilities
]

{ #category : #randomCreation }
EffectCreator >> moonwalkNumberCreator [
	^ (10 atRandom)
]
