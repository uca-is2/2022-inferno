Class {
	#name : #EffectCreatorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
