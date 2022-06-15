Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
ZathuraTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	|errorWasRaised errorMessage|
	errorBlock
	on: errorClass 
	do: [ :error |
		errorWasRaised := true.
		errorMessage := error messageText ].
]

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
ZathuraTest >> test02MovementByAnEffectDoesNotTriggerAnotherEffect [

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
ZathuraTest >> test03NoEffectDoesNotMovesAnySpaceship [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: NoEffect  new.
		
	aCollectionOfSpots := { firstSpot. secondSpot. thirdSpot. fourthSpot. fifthSpot. sixthSpot}.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALengthOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	aDie1 := LoadedDie with:5 loadedWith:5.
	aCollectionOfDice := { aDie1.}.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn .
	
	positionOfSpaceship :=  zathura positionOf: 'SC30 StarFighter'.
	self assert: (positionOfSpaceship )spotNumber equals: 6.
]

{ #category : #tests }
ZathuraTest >> test04SpeedUpMovesASpaceshipFourSpotsForward [

		| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot  |
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
	zathura playNextTurn .
	
	positionOfSpaceship :=  zathura positionOf: 'SC30 StarFighter'.
	self assert: (positionOfSpaceship )spotNumber equals: 6.
]

{ #category : #tests }
ZathuraTest >> test05WormHoleMovesASpaceshipFourSpotsBackwards [

		| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot  |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: Wormhole  new.
		
	aCollectionOfSpots := { firstSpot. secondSpot. thirdSpot. fourthSpot. fifthSpot. sixthSpot}.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALengthOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	aDie1 := LoadedDie with:5 loadedWith:5.
	aCollectionOfDice := { aDie1.}.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn .
	
	positionOfSpaceship :=  zathura positionOf: 'SC30 StarFighter'.
	self assert: (positionOfSpaceship )spotNumber equals: 2.
]

{ #category : #tests }
ZathuraTest >> test06AtomicBombMovesAllTheSpacehipsToTheStart [

		| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceshipA firstSpot secondSpot thirdSpot fourthSpot fifthSpot   positionOfSpaceshipB positionOfSpaceshipC |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: AtomicBomb new.

		
	aCollectionOfSpots := { firstSpot. secondSpot. thirdSpot. fourthSpot. fifthSpot}.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALengthOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	aDie1 := LoadedDie with:5 loadedWith:2.
	aCollectionOfDice := { aDie1.}.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn .
	zathura playNextTurn .
	zathura playNextTurn .
	zathura playNextTurn .
	
	positionOfSpaceshipA :=  zathura positionOf: 'SC30 StarFighter'.
	positionOfSpaceshipB :=  zathura positionOf: 'SC30 StarFighter'.
	positionOfSpaceshipC :=  zathura positionOf: 'SC30 StarFighter'.
	self assert: (positionOfSpaceshipA )spotNumber equals: 1.
	self assert: (positionOfSpaceshipB )spotNumber equals: 1.
	self assert: (positionOfSpaceshipC )spotNumber equals: 1.
]

{ #category : #tests }
ZathuraTest >> test07RankingOrdersAndAssertsCorrectPosition [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura  firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot expectedRanking chequeoRankings |
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
	expectedRanking := OrderedCollection  new: 3.
	expectedRanking addLast:  {'SC30 StarFighter'. 1. 1}.
	expectedRanking addLast: {'Millenium Falcon'. 0. 6}.
	expectedRanking addLast: {'Razor Crest'. 0. 6}.

	zathura playNextTurn .
	zathura playNextTurn .
	zathura playNextTurn .
	zathura playNextTurn .
	chequeoRankings := zathura rankingOfSpaceships .
	self assert: chequeoRankings equals: expectedRanking.
	
	
]

{ #category : #tests }
ZathuraTest >> test08PlayNextTurnDoesNotAllowSpaceshipToPlayWhenNotItsTurn [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot expectedPosition seventhSpot error errorMessage invalidTurn |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: SpeedUp  new.
	seventhSpot := Spot createWith: NoEffect new.
	
	error := Error.
	errorMessage := 'Cannot move that spaceship as it is not its turn.'.
		
	aCollectionOfSpots := { firstSpot. secondSpot. thirdSpot. fourthSpot. fifthSpot. sixthSpot. seventhSpot.}.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALengthOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	aDie1 := LoadedDie with:5 loadedWith:3.
	aCollectionOfDice := { aDie1.}.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	expectedPosition := 7.
	invalidTurn := [zathura playTurn: 'Millenium Falcon' .].
	
	self should: invalidTurn raise: error withMessage: errorMessage. 
]

{ #category : #tests }
ZathuraTest >> test09MoonwalkMovesEveryOtherSpaceshipAnAmountOfSpotsBackwards [

		| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceshipA firstSpot secondSpot thirdSpot fourthSpot fifthSpot   positionOfSpaceshipB positionOfSpaceshipThatTriggeredTheMoonwalk |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: (Moonwalk createWith: 1).

	aCollectionOfSpots := { firstSpot. secondSpot. thirdSpot. fourthSpot. fifthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALengthOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	aDie1 := LoadedDie with:5 loadedWith:2.
	aCollectionOfDice := { aDie1.}.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn .
	zathura playNextTurn .
	zathura playNextTurn .
	zathura playNextTurn .
	
	positionOfSpaceshipThatTriggeredTheMoonwalk :=  zathura positionOf: 'SC30 StarFighter'.
	positionOfSpaceshipB :=  zathura positionOf: 'Millenium Falcon'.
	positionOfSpaceshipA :=  zathura positionOf: 'Razor Crest'.
	self assert: (positionOfSpaceshipA)spotNumber equals: 2.
	self assert: (positionOfSpaceshipB)spotNumber equals: 2.
	self assert: (positionOfSpaceshipThatTriggeredTheMoonwalk)spotNumber equals: 5.
]

{ #category : #tests }
ZathuraTest >> test10HyperJumpsMakesFirstJumpAnAmountOfParsecsForward [

		| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot fifthSpot positionOfSpaceshipThatJumps arrayOfJumps |
	firstSpot := Spot createWith: NoEffect new.
	
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: {2. 4. 6}.
	secondSpot := Spot createWith: (Hyperjump  createWith: arrayOfJumps).
	
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot  := Spot createWith: NoEffect new.

	aCollectionOfSpots := { firstSpot. secondSpot. thirdSpot. fourthSpot. fifthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	aBoard := Board with: aCollectionOfSpots  withALengthOf: 10 around: 3 playedBy: aCollectionOfSpaceships.
	aDie1 := LoadedDie with:5 loadedWith:1.
	aCollectionOfDice := { aDie1.}.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	zathura playNextTurn .
	positionOfSpaceshipThatJumps :=  zathura positionOf: 'SC30 StarFighter'.
	self assert: (positionOfSpaceshipThatJumps)spotNumber equals: 5.
]
