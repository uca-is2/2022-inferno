Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraTest >> test01AGameOfZathuraInfernoCanBePlayedByTurnsTilFinished [

	| aCollectionOfSpaceships aBoard aCollectionOfSpots anEffectFiller aCollectionOfMoonwalkNumbers aCollectionOfJumpArrays lengthInParsecs aDiceCup aCollectionOfDice zathura aDie1 aDie2 firstHyperJumpValues secondHyperJumpValues thirdHyperJumpValues fourthHyperJumpValues fifthHyperJumpValues sixthHyperJumpValues seventhHyperJumpValues eigthHyperJumpValues |
	anEffectFiller := EffectFiller new.
	aCollectionOfMoonwalkNumbers:= {5. 3. 2. 1. 2. 3. 5. 3. 2. 4.}.
	firstHyperJumpValues := OrderedCollection new: 3.
	firstHyperJumpValues addAllFirst: {1. 2. 3}.
	
	secondHyperJumpValues := OrderedCollection new: 3.
	secondHyperJumpValues addAllFirst: {0. 3. 5}.
	
	thirdHyperJumpValues := OrderedCollection new: 3.
	thirdHyperJumpValues addAllFirst: {2. 4. 6}.
	
	fourthHyperJumpValues := OrderedCollection new: 3.
	fourthHyperJumpValues addAllFirst: {3. 4. 5}.
	
	fifthHyperJumpValues := OrderedCollection new: 3.
	fifthHyperJumpValues addAllFirst: {1. 2. 3}.
	
	sixthHyperJumpValues := OrderedCollection new: 3.
	sixthHyperJumpValues addAllFirst: {1. 3. 5}.
	
	seventhHyperJumpValues := OrderedCollection new: 3.
	seventhHyperJumpValues addAllFirst: {2. 5. 6}.
	
	eigthHyperJumpValues := OrderedCollection new: 3.
	eigthHyperJumpValues addAllFirst: {1. 4. 5}.

	aCollectionOfJumpArrays:= {firstHyperJumpValues. secondHyperJumpValues. thirdHyperJumpValues. fourthHyperJumpValues. fifthHyperJumpValues. sixthHyperJumpValues. seventhHyperJumpValues. eigthHyperJumpValues }.
	aCollectionOfSpots :=  anEffectFiller fillWithEffects: 100 with: aCollectionOfJumpArrays and: aCollectionOfMoonwalkNumbers .
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	lengthInParsecs := 100.
	aBoard := Board with: aCollectionOfSpots withALengthOf: lengthInParsecs around: 3 playedBy: aCollectionOfSpaceships.
	aDie1:= Die with: 7.
	aDie2:= Die with: 6.
	aCollectionOfDice := { aDie1. aDie2. }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	[ zathura hasGameFinished ] whileFalse: [ zathura playNextTurn ].
	self assert: zathura hasGameFinished.
]

{ #category : #tests }
ZathuraTest >> test01AGameOfZathuraInfernoCanBePlayedByTurnsTilFinishedWithLoadedDie [

	| aCollectionOfSpaceships aBoard aCollectionOfSpots anEffectFiller aCollectionOfMoonwalkNumbers aCollectionOfJumpArrays lengthInParsecs aDiceCup aCollectionOfDice zathura aDie1 aDie2 firstHyperJumpValues secondHyperJumpValues thirdHyperJumpValues fourthHyperJumpValues |
	anEffectFiller := EffectFiller new.
	aCollectionOfMoonwalkNumbers:= {5. 3. 2. 1. 2 }.
	firstHyperJumpValues := OrderedCollection new: 3.
	firstHyperJumpValues addAllFirst: {1. 2. 3}.
	
	secondHyperJumpValues := OrderedCollection new: 3.
	secondHyperJumpValues addAllFirst: {0. 3. 5}.
	
	thirdHyperJumpValues := OrderedCollection new: 3.
	thirdHyperJumpValues addAllFirst: {2. 4. 6}.
	
	fourthHyperJumpValues := OrderedCollection new: 3.
	fourthHyperJumpValues addAllFirst: {3. 4. 5}.

	aCollectionOfJumpArrays:= {firstHyperJumpValues. secondHyperJumpValues. thirdHyperJumpValues. fourthHyperJumpValues }.
	aCollectionOfSpots :=  anEffectFiller fillWithEffects: 49 with: aCollectionOfJumpArrays and: aCollectionOfMoonwalkNumbers .
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	lengthInParsecs := 100.
	aBoard := Board with: aCollectionOfSpots withALengthOf: lengthInParsecs around: 3 playedBy: aCollectionOfSpaceships.
	aDie1:= LoadedDie with:5 loadedWith:4.
	aDie2:= LoadedDie with:6 loadedWith: 6.
	aCollectionOfDice := { aDie1. aDie2. }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	[ zathura hasGameFinished ] whileFalse: [ zathura playNextTurn ].
	self assert: zathura hasGameFinished.
]

{ #category : #tests }
ZathuraTest >> test02AnEffectDoesNotTriggerAnotherEffect [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot expectedPosition |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: SpeedUp  new.
		
	aCollectionOfSpots := { firstSpot. secondSpot. thirdSpot. fourthSpot. fifthSpot. sixthSpot}.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALengthOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	aDie1 := LoadedDie with:5 loadedWith:1.
	aCollectionOfDice := { aDie1.}.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	expectedPosition := 6.
	zathura playNextTurn .
	
	positionOfSpaceship :=  zathura positionOf: 'SC30 StarFighter'.
	self assert: (positionOfSpaceship )spotNumber equals: expectedPosition.
]

{ #category : #tests }
ZathuraTest >> test03RankingOrdersAndAssertsCorrectPosition [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura  firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot expectedRanking |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: NoEffect  new.
		
	aCollectionOfSpots := { firstSpot. secondSpot. thirdSpot. fourthSpot. fifthSpot. sixthSpot}.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALengthOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	aDie1 := LoadedDie with:5 loadedWith:1.
	aCollectionOfDice := { aDie1.}.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	expectedRanking := [['SC30 StarFighter', 2,1],['Razor Crest', 1, 6],['Millenium Falcon', 1, 6]].
	zathura playNextTurn .
	zathura playNextTurn .
	zathura playNextTurn .
	zathura playNextTurn .
	self assert: (zathura rankingOfSpaceships equals: expectedRanking).
	
	
]

{ #category : #tests }
ZathuraTest >> test04PlayNextTurnDoesNotAllowSpaceshipToPlayWhenNotItsTurn [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot expectedPosition seventhSpot |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: SpeedUp  new.
	seventhSpot := Spot createWith: NoEffect new.
		
	aCollectionOfSpots := { firstSpot. secondSpot. thirdSpot. fourthSpot. fifthSpot. sixthSpot. seventhSpot.}.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALengthOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	aDie1 := LoadedDie with:5 loadedWith:3.
	aCollectionOfDice := { aDie1.}.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	expectedPosition := 7.
	zathura playTurn: 'Millenium Falcon' .
	zathura playTurn: 'SC30 StarFighter' .
	zathura playTurn: 'SC30 StarFighter' .
	
	positionOfSpaceship :=  zathura positionOf: 'SC30 StarFighter'.
	"self assert: (positionOfSpaceship )spotNumber equals: expectedPosition."
	self assert: false.
]
