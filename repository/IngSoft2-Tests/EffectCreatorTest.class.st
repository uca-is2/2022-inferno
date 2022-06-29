Class {
	#name : #EffectCreatorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
EffectCreatorTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ]
]

{ #category : #tests }
EffectCreatorTest >> test01EffectCreatorCreatesACollectionOfSpotsOfGivenSize [
	| boardLayout amountOfSpots aDictionaryWithEffectProbabilities anEffectCreator |
	anEffectCreator := EffectCreator new.
	amountOfSpots := 10.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: 'SpeedUp' put: 20.
	aDictionaryWithEffectProbabilities at: 'Wormhole' put: 20.
	aDictionaryWithEffectProbabilities at: 'AtomicBomb' put: 2.
	aDictionaryWithEffectProbabilities at: 'Moonwalk' put: 10.
	aDictionaryWithEffectProbabilities at: 'Hyperjump' put: 8.
	aDictionaryWithEffectProbabilities at: 'CardPicker' put: 10.
	
	boardLayout := anEffectCreator for: amountOfSpots with: aDictionaryWithEffectProbabilities.
	self assert: (boardLayout size) equals: amountOfSpots.
]

{ #category : #tests }
EffectCreatorTest >> test02EffectCreatorCreatesACollectionOfSpotsWithProportionOfEffectsGivenByProbability [
	| boardLayout amountOfSpots aDictionaryWithEffectProbabilities anEffectCreator |
	anEffectCreator := EffectCreator new.
	amountOfSpots := 10.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: 'SpeedUp' put: 95.
	aDictionaryWithEffectProbabilities at: 'Wormhole' put: 1.
	aDictionaryWithEffectProbabilities at: 'AtomicBomb' put: 1.
	aDictionaryWithEffectProbabilities at: 'Moonwalk' put: 1.
	aDictionaryWithEffectProbabilities at: 'Hyperjump' put: 1.
	aDictionaryWithEffectProbabilities at: 'CardPicker' put: 1.
	
	boardLayout := anEffectCreator for: amountOfSpots with: aDictionaryWithEffectProbabilities.
	self assert: ((((boardLayout at: 9)effectAtSpot) isKindOf: SpeedUp)or:((((boardLayout at: 8)effectAtSpot) isKindOf: SpeedUp))) .
]

{ #category : #tests }
EffectCreatorTest >> test03EffectCreatorDoesFailIfSumOfEffectProbabilitiesExceedOneHundredPercent [
	| boardLayout amountOfSpots aDictionaryWithEffectProbabilities anEffectCreator errorMessage error |
	anEffectCreator := EffectCreator new.
	amountOfSpots := 10.
	errorMessage:='Sum of probabilities exceeds 100 percent.'.
	error:=Error.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: 'SpeedUp' put: 51.
	aDictionaryWithEffectProbabilities at: 'Wormhole' put: 20.
	aDictionaryWithEffectProbabilities at: 'AtomicBomb' put: 2.
	aDictionaryWithEffectProbabilities at: 'Moonwalk' put: 10.
	aDictionaryWithEffectProbabilities at: 'Hyperjump' put: 8.
	aDictionaryWithEffectProbabilities at: 'CardPicker' put: 10.
	
	boardLayout := [anEffectCreator for: amountOfSpots with: aDictionaryWithEffectProbabilities].
	self should: boardLayout raise: error withMessage: errorMessage.
]

{ #category : #tests }
EffectCreatorTest >> test04EffectCreatorDoesFailIfAProbabilityIsNegative [
	| boardLayout amountOfSpots aDictionaryWithEffectProbabilities anEffectCreator errorMessage error |
	anEffectCreator := EffectCreator new.
	amountOfSpots := 10.
	errorMessage:='Effect probability cannot be zero or lower.'.
	error:=Error.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: 'SpeedUp' put: -5.
	aDictionaryWithEffectProbabilities at: 'Wormhole' put: 20.
	aDictionaryWithEffectProbabilities at: 'AtomicBomb' put: 2.
	aDictionaryWithEffectProbabilities at: 'Moonwalk' put: 10.
	aDictionaryWithEffectProbabilities at: 'Hyperjump' put: 8.
	aDictionaryWithEffectProbabilities at: 'CardPicker' put: 10.
	
	boardLayout := [anEffectCreator for: amountOfSpots with: aDictionaryWithEffectProbabilities].
	self should: boardLayout raise: error withMessage: errorMessage.
]

{ #category : #tests }
EffectCreatorTest >> test05EffectCreatorDoesFailIfAmountOfSpotsIsZeroOrLower [
	| boardLayout amountOfSpots aDictionaryWithEffectProbabilities anEffectCreator errorMessage error |
	anEffectCreator := EffectCreator new.
	amountOfSpots := 0.
	errorMessage:='Cannot create a layout with size zero or lower.'''.
	error:=Error.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: 'SpeedUp' put: -5.
	aDictionaryWithEffectProbabilities at: 'Wormhole' put: 20.
	aDictionaryWithEffectProbabilities at: 'AtomicBomb' put: 2.
	aDictionaryWithEffectProbabilities at: 'Moonwalk' put: 10.
	aDictionaryWithEffectProbabilities at: 'Hyperjump' put: 8.
	aDictionaryWithEffectProbabilities at: 'CardPicker' put: 10.
	
	boardLayout := [anEffectCreator for: amountOfSpots with: aDictionaryWithEffectProbabilities].
	self should: boardLayout raise: error withMessage: errorMessage.
]
