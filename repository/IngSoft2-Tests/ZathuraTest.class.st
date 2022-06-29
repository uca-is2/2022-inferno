Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
ZathuraTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ]
]

{ #category : #tests }
ZathuraTest >> test01AGameOfZathuraInfernoCanBePlayedByTurnsTilFinishedWithRandomlyGeneratedBoardLayoutAndDies [

	| aCollectionOfSpaceships aBoard aCollectionOfSpots anEffectCreator lengthInParsecs aDiceCup aCollectionOfDice zathura aDie1 aDie2 aHand1 aHand2 aHand3 aCollectionOfHands aDictionaryWithEffectProbabilities |
	anEffectCreator := EffectCreator new.
	aDictionaryWithEffectProbabilities := Dictionary new.
	aDictionaryWithEffectProbabilities at: 'SpeedUp' put: 20.
	aDictionaryWithEffectProbabilities at: 'Wormhole' put: 20.
	aDictionaryWithEffectProbabilities at: 'AtomicBomb' put: 2.
	aDictionaryWithEffectProbabilities at: 'Moonwalk' put: 10.
	aDictionaryWithEffectProbabilities at: 'Hyperjump' put: 8.
	aDictionaryWithEffectProbabilities at: 'CardPicker' put: 10.
	aCollectionOfSpots := anEffectCreator for: 1000 with: aDictionaryWithEffectProbabilities.
	
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	lengthInParsecs := 100.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: lengthInParsecs
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := Die with: 7.
	aDie2 := Die with: 6.
	aCollectionOfDice := { 
		                     aDie1.
		                     aDie2 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	aHand1 := (aBoard dealer) dealInitialCards.
	aHand2 := (aBoard dealer) dealInitialCards.
	aHand3 := (aBoard dealer) dealInitialCards.
	aCollectionOfHands := { aHand1. aHand2. aHand3 }.

	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	[ zathura hasGameFinished ] whileFalse: [ zathura playNextTurn ].
	self assert: zathura hasGameFinished
]

{ #category : #tests }
ZathuraTest >> test02MovementByAnEffectDoesNotTriggerAnotherEffect [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot expectedPosition exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: SpeedUp new.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	expectedPosition := 6.
	zathura playNextTurn.

	positionOfSpaceship := zathura positionOf: 'SC30 StarFighter'.
	self assert: positionOfSpaceship spotNumber equals: expectedPosition
]

{ #category : #tests }
ZathuraTest >> test03NoEffectDoesNotMovesAnySpaceship [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 5.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.

	positionOfSpaceship := zathura positionOf: 'SC30 StarFighter'.
	self assert: positionOfSpaceship spotNumber equals: 6
]

{ #category : #tests }
ZathuraTest >> test04SpeedUpMovesASpaceshipFourSpotsForward [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.

	positionOfSpaceship := zathura positionOf: 'SC30 StarFighter'.
	self assert: positionOfSpaceship spotNumber equals: 6
]

{ #category : #tests }
ZathuraTest >> test05WormHoleMovesASpaceshipFourSpotsBackwards [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceship firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: Wormhole new.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 5.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.

	positionOfSpaceship := zathura positionOf: 'SC30 StarFighter'.
	self assert: positionOfSpaceship spotNumber equals: 2
]

{ #category : #tests }
ZathuraTest >> test06AtomicBombMovesAllTheSpacehipsToTheStartOfSameLap [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceshipA firstSpot secondSpot thirdSpot fourthSpot fifthSpot positionOfSpaceshipB positionOfSpaceshipC exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: AtomicBomb new.


	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 2.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.

	positionOfSpaceshipA := zathura positionOf: 'SC30 StarFighter'.
	positionOfSpaceshipB := zathura positionOf: 'SC30 StarFighter'.
	positionOfSpaceshipC := zathura positionOf: 'SC30 StarFighter'.
	self assert: positionOfSpaceshipA spotNumber equals: 1.
	self assert: positionOfSpaceshipB spotNumber equals: 1.
	self assert: positionOfSpaceshipC spotNumber equals: 1
]

{ #category : #tests }
ZathuraTest >> test07ZathuraCanReturnFinalRankingsInCorrectOrder [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot expectedRanking chequeoRankings exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands firstExpectedPosition secondExpectedPosition thirdExpectedPosition |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	
	firstExpectedPosition := Position at: 1 on: 1.
	secondExpectedPosition := Position at: 0 on: 6.
	thirdExpectedPosition := Position at: 0 on: 6.
	
	expectedRanking := Dictionary new: 3.
	expectedRanking at: 'SC30 StarFighter' put: firstExpectedPosition .
	expectedRanking at: 'Millenium Falcon' put: firstExpectedPosition .
	expectedRanking at: 'Razor Crest' put: firstExpectedPosition .

	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	chequeoRankings := zathura rankingOfSpaceships.
	self assert: (chequeoRankings at: 'SC30 StarFighter')lapNumber equals: (expectedRanking at: 'SC30 StarFighter')lapNumber.
	self assert: (chequeoRankings at: 'SC30 StarFighter')spotNumber equals: (expectedRanking at: 'SC30 StarFighter')spotNumber. 
]

{ #category : #tests }
ZathuraTest >> test08PlayNextTurnDoesNotAllowSpaceshipToPlayWhenNotItsTurn [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot expectedPosition seventhSpot error errorMessage invalidTurn exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: SpeedUp new.
	seventhSpot := Spot createWith: NoEffect new.

	error := Error.
	errorMessage := 'Cannot move that spaceship as it is not its turn.'.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot.
		                      seventhSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	expectedPosition := 7.
	invalidTurn := [ zathura playTurn: 'Millenium Falcon' ].

	self should: invalidTurn raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test09MoonwalkMovesEveryOtherSpaceshipAnAmountOfSpotsBackwards [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura positionOfSpaceshipA firstSpot secondSpot thirdSpot fourthSpot fifthSpot positionOfSpaceshipB positionOfSpaceshipThatTriggeredTheMoonwalk exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: (Moonwalk createWith: 1).

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 2.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.

	positionOfSpaceshipThatTriggeredTheMoonwalk := zathura positionOf:
		                                               'SC30 StarFighter'.
	positionOfSpaceshipB := zathura positionOf: 'Millenium Falcon'.
	positionOfSpaceshipA := zathura positionOf: 'Razor Crest'.
	self assert: positionOfSpaceshipA spotNumber equals: 2.
	self assert: positionOfSpaceshipB spotNumber equals: 2.
	self
		assert: positionOfSpaceshipThatTriggeredTheMoonwalk spotNumber
		equals: 5
]

{ #category : #tests }
ZathuraTest >> test10HyperJumpsMakesFirstJumpSeventeenLightyearsForward [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot fifthSpot positionOfSpaceshipThatJumps arrayOfJumps exampleCardOne exampleCardTwo aHand1 aHand2 aCollectionOfHands aHand3 |
	firstSpot := Spot createWith: NoEffect new.

	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { Lightyear distanceOf: 17. Parsec distanceOf: 4. Parsec distanceOf: 6 }.
	secondSpot := Spot createWith:
		              (Hyperjump
			               createWith: arrayOfJumps).

	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.
	positionOfSpaceshipThatJumps := zathura positionOf:
		                                'SC30 StarFighter'.
	self assert: positionOfSpaceshipThatJumps spotNumber equals: 5
]

{ #category : #tests }
ZathuraTest >> test11ZathuraDealsTwoCardsToEachSpaceshipToStart [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot spaceshipCards1 spaceshipCards2 aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	spaceshipCards1 := (zathura handOf: 'Razor Crest') cardsOnHand.
	spaceshipCards2 := (zathura handOf: 'Millenium Falcon') cardsOnHand.
	self assert: spaceshipCards1 = 2 & (spaceshipCards2 = 2)
]

{ #category : #tests }
ZathuraTest >> test12AssertASpaceshipAppliesOverloadToAnotherOneAndDecreasesItsRollByTwo [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo cardToPlay |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura
		           playWith: aDiceCup
		           over: aBoard
		           dealing: aCollectionOfHands.
	zathura playNextTurn.
	cardToPlay := OverloadCard new.
	zathura play: cardToPlay by: 'Millenium Falcon' affecting: 'Razor Crest'.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 1
]

{ #category : #tests }
ZathuraTest >> test13AssertASpaceshipAppliesSpeedToAnotherOneAndIncreasesItsRollByOne [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo cardToPlay |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura
		           playWith: aDiceCup
		           over: aBoard
		           dealing: aCollectionOfHands.
	zathura playNextTurn.
	cardToPlay := SpeedCard new.
	zathura play: cardToPlay by: 'Millenium Falcon' affecting: 'Razor Crest'.
	zathura playNextTurn.
	zathura playNextTurn.
	zathura playNextTurn.
	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 4
]

{ #category : #tests }
ZathuraTest >> test14AssertASpaceshipAppliesAccelerationAndIncreasesRollByOneForEveryone [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo cardToPlay |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := AccelerationCard new.
	exampleCardTwo := OverloadCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.
	zathura playNextTurn.
	cardToPlay := AccelerationCard new.
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'General'.
	zathura playNextTurn.
	zathura playNextTurn.
	self assert: (zathura positionOf: 'Razor Crest') spotNumber = 4
		& ((zathura positionOf: 'Millenium Falcon') spotNumber = 4)
]

{ #category : #tests }
ZathuraTest >> test15AssertASpaceshipCanRemoveAnOverloadCardUsingACancelationCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo cardToPlay cardToPlay2 |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := CancellationCard new.
	exampleCardTwo := OverloadCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.
	zathura playNextTurn.
	cardToPlay := OverloadCard new.
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'Millenium Falcon'.
	cardToPlay2 := CancellationCard new.
	zathura play: cardToPlay2  by: 'Millenium Falcon' affecting: {'Millenium Falcon'. cardToPlay }.
	zathura playNextTurn.
	zathura playNextTurn.
	self assert: (zathura positionOf: 'Razor Crest') spotNumber = 3
		& ((zathura positionOf: 'Millenium Falcon') spotNumber = 3)
]

{ #category : #tests }
ZathuraTest >> test16AssertASpaceshipUsesRepeatCardAndLastTriggeredEffectIsDoneAgainToItself [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo fifthdSpot cardToPlay |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RepeatCard new.
	exampleCardTwo := OverloadCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.
	zathura playNextTurn.
	cardToPlay := RepeatCard new.
	zathura play: cardToPlay by: 'Millenium Falcon' affecting: 'Millenium Falcon'.

	self
		assert: (zathura positionOf: 'Millenium Falcon') spotNumber
		equals: 5
]

{ #category : #tests }
ZathuraTest >> test17AssertASpaceshipRedoesSpeedCardUsingARedoCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo fifthdSpot cardToPlay |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := SpeedCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.
	zathura playNextTurn.
	cardToPlay := SpeedCard new.
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'Razor Crest'.
	cardToPlay := RedoCard new.
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'Razor Crest'.
	zathura playNextTurn.
	zathura playNextTurn.

	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 5
]

{ #category : #tests }
ZathuraTest >> test18AssertASpaceshipRedoesAccelerationCardUsingRedoCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo fifthdSpot cardToPlay |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := AccelerationCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.
	zathura playNextTurn.
	cardToPlay := AccelerationCard new.
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'General'.
	cardToPlay := RedoCard new.
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'General'.
	zathura playNextTurn.
	zathura playNextTurn.

	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 5.
	self
		assert: (zathura positionOf: 'Millenium Falcon') spotNumber
		equals: 5.
]

{ #category : #tests }
ZathuraTest >> test19AssertASpaceshipRedoesCancellationCardUsingRedoCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo fifthdSpot cardToPlay cardToPlay2 exampleCardThree exampleCardFour cardToPlay3 cardToPlay4 |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := AccelerationCard new.
	exampleCardThree := OverloadCard new.
	exampleCardFour := CancellationCard new.
	aHand1 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardThree. }.
	aHand2 := Hand containing: { 
			          exampleCardOne.
			          exampleCardFour }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.
	zathura playNextTurn.
	cardToPlay := AccelerationCard new.
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'General'.
	cardToPlay2 := OverloadCard new.
	zathura play: cardToPlay2 by: 'Razor Crest' affecting: 'Millenium Falcon'.
	cardToPlay3 := CancellationCard new.
	zathura play: cardToPlay3 by: 'Millenium Falcon' affecting: {'Millenium Falcon'. cardToPlay2 }.
	cardToPlay4 := RedoCard new.
	zathura play: cardToPlay4 by: 'Millenium Falcon' affecting: {'General'. cardToPlay }.
	zathura playNextTurn.
	zathura playNextTurn.

	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 3.
	self
		assert: (zathura positionOf: 'Millenium Falcon') spotNumber
		equals: 3
]

{ #category : #tests }
ZathuraTest >> test20AssertASpaceshipRedoesRepeatCardUsingARedoCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo fifthdSpot cardToPlay |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.
	zathura playNextTurn.
	cardToPlay := RepeatCard new.
	zathura play: cardToPlay by: 'Millenium Falcon' affecting: 'Millenium Falcon'.
	cardToPlay := RedoCard new.
	zathura play: cardToPlay by: 'Razor Crest' affecting: 'Razor Crest'.

	self assert: (zathura positionOf: 'Razor Crest') spotNumber equals: 5.
	self
		assert: (zathura positionOf: 'Millenium Falcon') spotNumber
		equals: 5
]

{ #category : #tests }
ZathuraTest >> test21SpaceshipCanAskWhatCardsItHasInHand [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo fifthdSpot spaceshipHand |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	spaceshipHand := zathura showCardsOnHandFor: 'Millenium Falcon'.
	self assert: spaceshipHand equals: aHand2 showHand
]

{ #category : #tests }
ZathuraTest >> test22CardPickerDealsARandomCardToTheTriggeringSpaceship [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthdSpot aHand1 aHand2 aCollectionOfHands exampleCardOne exampleCardTwo fifthdSpot spaceshipHand |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: CardPicker new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthdSpot := Spot createWith: NoEffect new.
	fifthdSpot := Spot createWith: NoEffect new.
	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthdSpot.
		                      fifthdSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 1.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := RedoCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.

	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2 }.
	zathura := Zathura playWith: aDiceCup over: aBoard dealing: aCollectionOfHands.
	zathura playNextTurn.
	spaceshipHand := zathura handOf: 'Razor Crest'.
	self assert: spaceshipHand cardsOnHand equals: 3
]

{ #category : #tests }
ZathuraTest >> test23SpaceshipCannotPlayPermanentCardWhenItIsNotItsTurn [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot error errorMessage invalidCardUse exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands cardToUse |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	error := Error.
	errorMessage := 'Cannot use permanent card if it is not this spaceships  turn.'.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := AccelerationCard new.
	exampleCardTwo := RepeatCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura
		           playWith: aDiceCup
		           over: aBoard
		           dealing: aCollectionOfHands.
	cardToUse := AccelerationCard new.
	invalidCardUse := [ 
	                  zathura
		                  currentSpaceshipPlaysCard: cardToUse
		                  playedBy: 'Millenium Falcon' ].

	self should: invalidCardUse raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test24SpaceshipCannotUseRedoOfPermanentCardWhenItIsNotItsTurn [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot error errorMessage invalidCardUse exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands cardToUse |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	error := Error.
	errorMessage := 'Cannot use redo card on a permanent if it is not this spaceships  turn.'.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := AccelerationCard new.
	exampleCardTwo := RedoCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura
		           playWith: aDiceCup
		           over: aBoard
		           dealing: aCollectionOfHands.
	cardToUse := AccelerationCard new.
	zathura
		currentSpaceshipPlaysCard: cardToUse
		playedBy: 'SC30 StarFighter'.
	invalidCardUse := [ zathura redoLastCardPlayedBy: 'Millenium Falcon' ].

	self should: invalidCardUse raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test25SpaceshipCannotUseRedoCardIfNoCardHasBeenPlayedYet [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot error errorMessage invalidCardUse exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	error := Error.
	errorMessage := 'Cannot use redo card if nobody has played a card yet'.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := AccelerationCard new.
	exampleCardTwo := RedoCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura
		           playWith: aDiceCup
		           over: aBoard
		           dealing: aCollectionOfHands.
	invalidCardUse := [ zathura redoLastCardPlayedBy: 'Millenium Falcon' ].

	self should: invalidCardUse raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test26SpaceshipCannotPlayCardIfItDoesNotHasItInHisHand [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot error errorMessage invalidCardUse exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	error := Error.
	errorMessage := 'Cannot use a card that is not present in that spaceships hand'.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := AccelerationCard new.
	exampleCardTwo := RedoCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	zathura := Zathura
		           playWith: aDiceCup
		           over: aBoard
		           dealing: aCollectionOfHands.
	invalidCardUse := [ 
	                  zathura
		                  play: CancellationCard new
		                  by: 'Millenium Falcon'
		                  affecting: 'SC30 StarFighter' ].
	self should: invalidCardUse raise: error withMessage: errorMessage
]

{ #category : #tests }
ZathuraTest >> test27SpaceshipCanCancelAnAccelerationCard [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands expectedHandAfterUsage emptyCollection |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := AccelerationCard new.
	exampleCardTwo := CancellationCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	expectedHandAfterUsage := Hand containing: { exampleCardOne }.
	zathura := Zathura
		           playWith: aDiceCup
		           over: aBoard
		           dealing: aCollectionOfHands.
	zathura
		play: AccelerationCard new
		by: 'SC30 StarFighter'
		affecting: 'General'.
	zathura
		play: CancellationCard new
		by: 'Millenium Falcon'
		affecting: { 
				'General'.
				exampleCardOne }.
	self
		assert: (zathura showCardsOnHandFor: 'Millenium Falcon')
		equals: expectedHandAfterUsage showHand.
	emptyCollection := OrderedCollection new.
	self
		assert: (zathura cardsBeingAppliedOn: 'General')
		equals: emptyCollection
]

{ #category : #tests }
ZathuraTest >> test28SpaceshipCanCancelAnOverloadCardBeingAppliedOnItself [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands expectedHandAfterUsage emptyCollection |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := OverloadCard new.
	exampleCardTwo := CancellationCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	expectedHandAfterUsage := Hand containing: { exampleCardOne }.
	zathura := Zathura
		           playWith: aDiceCup
		           over: aBoard
		           dealing: aCollectionOfHands.
	zathura
		play: OverloadCard new
		by: 'SC30 StarFighter'
		affecting: 'Millenium Falcon'.
	zathura
		play: CancellationCard new
		by: 'Millenium Falcon'
		affecting: { 
				'Millenium Falcon'.
				exampleCardOne }.
	self
		assert: (zathura showCardsOnHandFor: 'Millenium Falcon')
		equals: expectedHandAfterUsage showHand.
	emptyCollection := OrderedCollection new.
	self
		assert: (zathura cardsBeingAppliedOn: 'Millenium Falcon')
		equals: emptyCollection
]

{ #category : #tests }
ZathuraTest >> test29SpaceshipCanCancelASpeedCardBeingAppliedOnAnotherSpaceship [

	| aBoard aCollectionOfSpaceships aCollectionOfSpots aDie1 aCollectionOfDice aDiceCup zathura firstSpot secondSpot thirdSpot fourthSpot exampleCardOne exampleCardTwo aHand1 aHand2 aHand3 aCollectionOfHands expectedHandAfterUsage emptyCollection |
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: NoEffect new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot }.
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'.
	                           'SC30 StarFighter' }.
	aBoard := Board
		          with: aCollectionOfSpots
		          and: 10
		          playedFor: 3
		          by: aCollectionOfSpaceships.
	aDie1 := LoadedDie with: 3.
	aCollectionOfDice := { aDie1 }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := CancellationCard new.
	aHand1 := Hand containing: { 
			          exampleCardOne.
			          exampleCardTwo }.
	aHand2 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aHand3 := Hand containing: { 
			          exampleCardTwo.
			          exampleCardOne }.
	aCollectionOfHands := { 
		                      aHand1.
		                      aHand2.
		                      aHand3 }.
	expectedHandAfterUsage := Hand containing: { exampleCardOne }.
	zathura := Zathura
		           playWith: aDiceCup
		           over: aBoard
		           dealing: aCollectionOfHands.
	zathura
		play: SpeedCard new
		by: 'SC30 StarFighter'
		affecting: 'SC30 StarFighter'.
	zathura
		play: CancellationCard new
		by: 'Millenium Falcon'
		affecting: { 
				'SC30 StarFighter'.
				exampleCardOne }.
	self
		assert: (zathura showCardsOnHandFor: 'Millenium Falcon')
		equals: expectedHandAfterUsage showHand.
	emptyCollection := OrderedCollection new.
	self
		assert: (zathura cardsBeingAppliedOn: 'SC30 StarFighter')
		equals: emptyCollection
]
