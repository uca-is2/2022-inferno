Class {
	#name : #EffectFillerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectFillerTest >> test01EffectFillerCreatesCollectionOfSpotsOfGivenSize [

	| anEffectFiller boardLayout aCollectionOfJumpArrays aCollectionOfMoonwalkNumbers firstJumpArray secondJumpArray thirdJumpArray fourthJumpArray |
	anEffectFiller := EffectFiller new.
	firstJumpArray := { 4. 3. 2 }.
	secondJumpArray := { 5. 2. 1 }.
	thirdJumpArray := { 4. 1. 0 }.
	fourthJumpArray := { 7. 2. 1 }.
	aCollectionOfJumpArrays := { 
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray.
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray }.
	aCollectionOfMoonwalkNumbers := { 3. 2. 5. 7. 1. 4. 6. 5. 7. 2 }.
	boardLayout := anEffectFiller
		               for: 100
		               with: aCollectionOfJumpArrays
		               and: aCollectionOfMoonwalkNumbers.
	self assert: ((boardLayout at: 97) isKindOf: Spot)
]

{ #category : #tests }
EffectFillerTest >> test02EffectFillerCreatesCollectionOfSpotsInWhichThirtyPercentAreNoEffect [

	| anEffectFiller boardLayout aCollectionOfJumpArrays aCollectionOfMoonwalkNumbers firstJumpArray secondJumpArray thirdJumpArray fourthJumpArray |
	anEffectFiller := EffectFiller new.
	firstJumpArray := { 4. 3. 2 }.
	secondJumpArray := { 5. 2. 1 }.
	thirdJumpArray := { 4. 1. 0 }.
	fourthJumpArray := { 7. 2. 1 }.
	aCollectionOfJumpArrays := { 
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray.
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray }.
	aCollectionOfMoonwalkNumbers := { 3. 2. 5. 7. 1. 4. 6. 5. 7. 2 }.
	boardLayout := anEffectFiller
		               for: 100
		               with: aCollectionOfJumpArrays
		               and: aCollectionOfMoonwalkNumbers.
	self
		assert: (anEffectFiller amountOfNoEffectsForThisSize: 100)
		equals: 30
]

{ #category : #tests }
EffectFillerTest >> test03EffectFillerCreatesCollectionOfSpotsInWhichTwentyPercentAreSpeedUps [

	| anEffectFiller boardLayout aCollectionOfJumpArrays aCollectionOfMoonwalkNumbers firstJumpArray secondJumpArray thirdJumpArray fourthJumpArray |
	anEffectFiller := EffectFiller new.
	firstJumpArray := { 4. 3. 2 }.
	secondJumpArray := { 5. 2. 1 }.
	thirdJumpArray := { 4. 1. 0 }.
	fourthJumpArray := { 7. 2. 1 }.
	aCollectionOfJumpArrays := { 
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray.
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray }.
	aCollectionOfMoonwalkNumbers := { 3. 2. 5. 7. 1. 4. 6. 5. 7. 2 }.
	boardLayout := anEffectFiller
		               for: 100
		               with: aCollectionOfJumpArrays
		               and: aCollectionOfMoonwalkNumbers.
	self
		assert: (anEffectFiller amountOfSpeedUpsForThisSize: 100)
		equals: 20
]

{ #category : #tests }
EffectFillerTest >> test04EffectFillerCreatesCollectionOfSpotsInWhichTwentyPercentAreWormholes [

	| anEffectFiller boardLayout aCollectionOfJumpArrays aCollectionOfMoonwalkNumbers firstJumpArray secondJumpArray thirdJumpArray fourthJumpArray |
	anEffectFiller := EffectFiller new.
	firstJumpArray := { 4. 3. 2 }.
	secondJumpArray := { 5. 2. 1 }.
	thirdJumpArray := { 4. 1. 0 }.
	fourthJumpArray := { 7. 2. 1 }.
	aCollectionOfJumpArrays := { 
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray.
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray }.
	aCollectionOfMoonwalkNumbers := { 3. 2. 5. 7. 1. 4. 6. 5. 7. 2 }.
	boardLayout := anEffectFiller
		               for: 100
		               with: aCollectionOfJumpArrays
		               and: aCollectionOfMoonwalkNumbers.
	self
		assert: (anEffectFiller amountOfWormholesForThisSize: 100)
		equals: 20
]

{ #category : #tests }
EffectFillerTest >> test05EffectFillerCreatesCollectionOfSpotsInWhichTenPercentAreMoonwalks [

	| anEffectFiller boardLayout aCollectionOfJumpArrays aCollectionOfMoonwalkNumbers firstJumpArray secondJumpArray thirdJumpArray fourthJumpArray |
	anEffectFiller := EffectFiller new.
	firstJumpArray := { 4. 3. 2 }.
	secondJumpArray := { 5. 2. 1 }.
	thirdJumpArray := { 4. 1. 0 }.
	fourthJumpArray := { 7. 2. 1 }.
	aCollectionOfJumpArrays := { 
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray.
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray }.
	aCollectionOfMoonwalkNumbers := { 3. 2. 5. 7. 1. 4. 6. 5. 7. 2 }.
	boardLayout := anEffectFiller
		               for: 100
		               with: aCollectionOfJumpArrays
		               and: aCollectionOfMoonwalkNumbers.
	self
		assert: (anEffectFiller amountOfMoonwalkForThisSize: 100)
		equals: 10
]

{ #category : #tests }
EffectFillerTest >> test06EffectFillerCreatesCollectionOfSpotsInWhichEightPercentAreHyperjumps [

	| anEffectFiller boardLayout aCollectionOfJumpArrays aCollectionOfMoonwalkNumbers firstJumpArray secondJumpArray thirdJumpArray fourthJumpArray |
	anEffectFiller := EffectFiller new.
	firstJumpArray := { 4. 3. 2 }.
	secondJumpArray := { 5. 2. 1 }.
	thirdJumpArray := { 4. 1. 0 }.
	fourthJumpArray := { 7. 2. 1 }.
	aCollectionOfJumpArrays := { 
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray.
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray }.
	aCollectionOfMoonwalkNumbers := { 3. 2. 5. 7. 1. 4. 6. 5. 7. 2 }.
	boardLayout := anEffectFiller
		               for: 100
		               with: aCollectionOfJumpArrays
		               and: aCollectionOfMoonwalkNumbers.
	self
		assert: (anEffectFiller amountOfHyperJumpsForThisSize: 10)
		equals: 0
]

{ #category : #tests }
EffectFillerTest >> test07EffectFillerCreatesCollectionOfSpotsInWhichTwoPercentAreAtomicBombs [

	| anEffectFiller boardLayout aCollectionOfJumpArrays aCollectionOfMoonwalkNumbers firstJumpArray secondJumpArray thirdJumpArray fourthJumpArray |
	anEffectFiller := EffectFiller new.
	firstJumpArray := { 4. 3. 2 }.
	secondJumpArray := { 5. 2. 1 }.
	thirdJumpArray := { 4. 1. 0 }.
	fourthJumpArray := { 7. 2. 1 }.
	aCollectionOfJumpArrays := { 
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray.
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray }.
	aCollectionOfMoonwalkNumbers := { 3. 2. 5. 7. 1. 4. 6. 5. 7. 2 }.
	boardLayout := anEffectFiller
		               for: 100
		               with: aCollectionOfJumpArrays
		               and: aCollectionOfMoonwalkNumbers.
	self
		assert: (anEffectFiller amountOfAtomicBombsForThisSize: 50)
		equals: 1
]

{ #category : #tests }
EffectFillerTest >> test08EffectFillerCreatesCollectionOfSpotsInWhichTenPercentAreCardPickers [

	| anEffectFiller boardLayout aCollectionOfJumpArrays aCollectionOfMoonwalkNumbers firstJumpArray secondJumpArray thirdJumpArray fourthJumpArray |
	anEffectFiller := EffectFiller new.
	firstJumpArray := { 4. 3. 2 }.
	secondJumpArray := { 5. 2. 1 }.
	thirdJumpArray := { 4. 1. 0 }.
	fourthJumpArray := { 7. 2. 1 }.
	aCollectionOfJumpArrays := { 
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray.
		                           firstJumpArray.
		                           secondJumpArray.
		                           thirdJumpArray.
		                           fourthJumpArray }.
	aCollectionOfMoonwalkNumbers := { 3. 2. 5. 7. 1. 4. 6. 5. 7. 2 }.
	boardLayout := anEffectFiller
		               for: 100
		               with: aCollectionOfJumpArrays
		               and: aCollectionOfMoonwalkNumbers.
	self
		assert: (anEffectFiller amountOfCardPickersForThisSize: 50)
		equals: 5
]
