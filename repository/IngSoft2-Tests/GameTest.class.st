Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	|errorWasRaised errorMessage|
	errorBlock
	on: errorClass 
	do: [ :error |
		errorWasRaised := true.
		errorMessage := error messageText ].
]

{ #category : #tests }
GameTest >> testAGameCanBeCreated [

	| aDice aBoard aGame |
	aDice := Die with: 6.
	aBoard := Board with: 70 andNumberOfParsecs: 30.
	aGame := Game
		         withDice: aDice
		         withBoard: aBoard
		         andAmountOfLaps: 3
		         withAmountOfSpaceships: 2.
	self assert: aGame isNotNil
]

{ #category : #tests }
GameTest >> testAGameCanBePlayedByIndividualTurns [

	| aDie1 aDie2 aBoard aGame aCollection aDiceCup |
	aDie1 := Die with: 6.
	aDie2 := Die with: 6.
	aCollection := Array new: 2.
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aDiceCup := DiceCup with: aCollection.
	aBoard := Board with: 50 andNumberOfParsecs: 300.
	aGame := Game
		         withDice: aDiceCup
		         withBoard: aBoard
		         andAmountOfLaps: 2
		         withAmountOfSpaceships: 3.
	[ aGame hasGameFinished ] whileFalse: [ aGame playNextTurn ].
	self assert: aGame hasGameFinished
]

{ #category : #tests }
GameTest >> testAGameCanBeStartedAndPlayedToTheEnd [

	| aDie1 aDie2 aDie3 aBoard aGame aCollection aDiceCup |
	aDie1 := Die with: 6.
	aDie2 := Die with: 4.
	aDie3 := Die with: 6.
	aCollection := Array new: 3.
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aCollection at: 3 put: aDie3.
	aDiceCup := DiceCup with: aCollection.
	aBoard := Board with: 50 andNumberOfParsecs: 304.
	aGame := Game
		         withDice: aDiceCup
		         withBoard: aBoard
		         andAmountOfLaps: 2
		         withAmountOfSpaceships: 5.
	aGame playEntireGame.
	self assert: aGame hasGameFinished
]

{ #category : #tests }
GameTest >> testAGameCannotBeCreatedWithoutBoard [

	| aGame error errorMessage aDie |
	aDie := Die with: 9.
	aGame := [ 
	         Game
		         withDice: aDie
		         withBoard: nil
		         andAmountOfLaps: nil
		         withAmountOfSpaceships: 2 ].
	error := Error.
	errorMessage := 'A game cannot be created without a board.'.
	self should: aGame raise: error withMessage: errorMessage
]

{ #category : #tests }
GameTest >> testAGameCannotBeCreatedWithoutDice [

	| aBoard aGame error errorMessage |
	aBoard := [ Board with: 70 ].
	aGame := [ 
	         Game
		         withDice: nil
		         withBoard: aBoard
		         andAmountOfLaps: nil
		         withAmountOfSpaceships: 2 ].
	error := Error.
	errorMessage := 'A game cannot be created without dice.'.
	self should: aGame raise: error withMessage: errorMessage
]

{ #category : #tests }
GameTest >> testAGameCannotBeCreatedWithoutNumberOfLaps [

	| aGame error errorMessage aDie |
	aDie := Die with: 9.
	aGame := [ 
	         Game
		         withDice: aDie
		         withBoard: 50
		         andAmountOfLaps: nil
		         withAmountOfSpaceships: 2 ].
	error := Error.
	errorMessage := 'A game cannot be created without a valid amount of laps.'.
	self should: aGame raise: error withMessage: errorMessage
]

{ #category : #tests }
GameTest >> testAGameCannotBeCreatedWithoutSpaceShips [

	| aGame error errorMessage aDie aBoard |
	aDie := Die with: 9.
	aBoard := Board with:70 andNumberOfParsecs: 15.
	aGame := [ 
	         Game
		         withDice: aDie
		         withBoard: aBoard
		         andAmountOfLaps: nil
		         withAmountOfSpaceships: 1 ].
	error := Error.
	errorMessage := 'A game cannot be created with a number of spaceships lower than two.'.
	self should: aGame raise: error withMessage: errorMessage
]

{ #category : #tests }
GameTest >> testAGameWithACustomLayoutToTestCanBeCreated [
	| aDice aBoard aGame aCustomLayout slotsOfNoEffect slotsOfSpeedUp |
	aCustomLayout := Dictionary new.
	slotsOfNoEffect := Array new: 6.
	
	slotsOfNoEffect at: 1 put: 1.
	slotsOfNoEffect at: 2 put: 2.
	slotsOfNoEffect at: 3 put: 3.
	slotsOfNoEffect at: 4 put: 4.
	slotsOfNoEffect at: 5 put: 5.
	slotsOfNoEffect at: 6 put: 6.
	
	slotsOfSpeedUp := Array new: 1.
	slotsOfSpeedUp at: 1 put: 7.
	aCustomLayout at: 'noEffect' put: slotsOfNoEffect.
	aCustomLayout at: 'speedUp' put: slotsOfSpeedUp.
	
	aDice := LoadedDie with: 6 loadedWith: 6.
	aBoard := Board withCustomLayout: aCustomLayout andNumberOfSlots: 7.
	aGame := Game
		         withDice: aDice
		         withBoard: aBoard
		         andAmountOfLaps: 3
		         withAmountOfSpaceships: 2.
	self assert: aGame isNotNil
]

{ #category : #tests }
GameTest >> testAtomicBombWorksAsExpected [
	| aDice aBoard aGame aCustomLayout slotsOfNoEffect slotsOfAtomicBombs noPowerUps expectedPositions expectedSlotAndLapOne expectedSlotAndLapTwo |
	aCustomLayout := Dictionary new.
	slotsOfNoEffect := Array new: 5.
	
	slotsOfNoEffect at: 1 put: 1.
	slotsOfNoEffect at: 2 put: 3.
	slotsOfNoEffect at: 3 put: 4.
	slotsOfNoEffect at: 4 put: 5.
	slotsOfNoEffect at: 5 put: 6.
	slotsOfAtomicBombs := Array new: 1.
	slotsOfAtomicBombs at: 1 put: 6.
	noPowerUps := Array new: 1.
	aCustomLayout at: 'noEffect' put: slotsOfNoEffect.
	aCustomLayout at: 'wormholes' put: noPowerUps.
	aCustomLayout at: 'speedUps' put: noPowerUps.
	aCustomLayout at: 'moonWalks' put: noPowerUps.
	aCustomLayout at: 'hyperJumps' put: noPowerUps.
	aCustomLayout at: 'atomicBombs' put: slotsOfAtomicBombs.
	
	
	expectedPositions := Dictionary new.
	expectedSlotAndLapOne := Array new: 2.
	expectedSlotAndLapTwo := Array new: 2.
	
	expectedSlotAndLapOne at: 1 put: 0.
	expectedSlotAndLapOne at: 2 put: 0.

	expectedSlotAndLapTwo at: 1 put: 0.
	expectedSlotAndLapTwo at: 2 put: 0.
	
	expectedPositions at: 1 put: expectedSlotAndLapOne.
	expectedPositions at: 2 put: expectedSlotAndLapTwo.
	
	aDice := LoadedDie with: 6 loadedWith: 6.
	aBoard := Board withCustomLayout: aCustomLayout andNumberOfSlots: 8.
	aGame := Game
		         withDice: aDice
		         withBoard: aBoard
		         andAmountOfLaps: 1
		         withAmountOfSpaceships: 2.
	aGame playNextTurn.
	self assert: aGame spaceshipPositioning equals: expectedPositions.
]

{ #category : #tests }
GameTest >> testMoonwalkWorksAsExpected [
	| aDice aBoard aGame aCustomLayout slotsOfNoEffect slotsOfMoonwalk expectedPositions noPowerUps singleMoonwalkSlot expectedSlotAndLapOne expectedSlotAndLapTwo |
	aCustomLayout := Dictionary new.
	slotsOfNoEffect := Array new: 5.
	
	slotsOfNoEffect at: 1 put: 1.
	slotsOfNoEffect at: 2 put: 3.
	slotsOfNoEffect at: 3 put: 4.
	slotsOfNoEffect at: 4 put: 5.
	slotsOfNoEffect at: 5 put: 6.
	noPowerUps := Array new: 1.
	aCustomLayout at: 'wormholes' put: noPowerUps.
	aCustomLayout at: 'speedUps' put: noPowerUps.
	aCustomLayout at: 'hyperJumps' put: noPowerUps.
	aCustomLayout at: 'atomicBombs' put: noPowerUps.
	
	singleMoonwalkSlot := Array new: 2.
	singleMoonwalkSlot at: 1 put: 2.
	singleMoonwalkSlot at: 2 put: 1.
	
	slotsOfMoonwalk := Array new: 1.
	slotsOfMoonwalk at: 1 put: singleMoonwalkSlot.
	aCustomLayout at: 'noEffect' put: slotsOfNoEffect.
	aCustomLayout at: 'moonWalks' put: slotsOfMoonwalk.
	expectedPositions := Dictionary new.
	expectedSlotAndLapOne := Array new: 2.
	expectedSlotAndLapTwo := Array new: 2.
	
	expectedSlotAndLapOne at: 1 put: 2.
	expectedSlotAndLapOne at: 2 put: 0.
	
	expectedSlotAndLapTwo at: 1 put: 0.
	expectedSlotAndLapTwo at: 2 put: 0.
	
	expectedPositions at: 1 put: expectedSlotAndLapOne.
	expectedPositions at: 2 put: expectedSlotAndLapTwo.
	
	aDice := LoadedDie with: 6 loadedWith: 2.
	aBoard := Board withCustomLayout: aCustomLayout andNumberOfSlots: 6.
	aGame := Game
		         withDice: aDice
		         withBoard: aBoard
		         andAmountOfLaps: 1
		         withAmountOfSpaceships: 2.
	aGame playNextTurn.
	self assert: aGame spaceshipPositioning equals: expectedPositions
]

{ #category : #tests }
GameTest >> testSpeedUpWorksAsExpected [
	| aDice aBoard aGame aCustomLayout slotsOfNoEffect slotsOfSpeedUp noPowerUps |
	aCustomLayout := Dictionary new.
	slotsOfNoEffect := Array new: 5.
	
	slotsOfNoEffect at: 1 put: 1.
	slotsOfNoEffect at: 2 put: 3.
	slotsOfNoEffect at: 3 put: 4.
	slotsOfNoEffect at: 4 put: 5.
	slotsOfNoEffect at: 5 put: 6.
	slotsOfSpeedUp := Array new: 1.
	slotsOfSpeedUp at: 1 put: 2.
	noPowerUps := Array new: 1.
	aCustomLayout at: 'noEffect' put: slotsOfNoEffect.
	aCustomLayout at: 'speedUps' put: slotsOfSpeedUp.
	aCustomLayout at: 'wormholes' put: noPowerUps.
	aCustomLayout at: 'moonWalks' put: noPowerUps.
	aCustomLayout at: 'hyperJumps' put: noPowerUps.
	aCustomLayout at: 'atomicBombs' put: noPowerUps.
	
	aDice := LoadedDie with: 6 loadedWith: 2.
	aBoard := Board withCustomLayout: aCustomLayout andNumberOfSlots: 6.
	aGame := Game
		         withDice: aDice
		         withBoard: aBoard
		         andAmountOfLaps: 1
		         withAmountOfSpaceships: 2.
	aGame playNextTurn.
	self assert: (aGame hasGameFinished)
]

{ #category : #tests }
GameTest >> testWormholesWorksAsExpected [
	| aDice aBoard aGame aCustomLayout slotsOfNoEffect slotsOfWormholes noPowerUps expectedPositions expectedSlotAndLapOne expectedSlotAndLapTwo |
	aCustomLayout := Dictionary new.
	slotsOfNoEffect := Array new: 5.
	
	slotsOfNoEffect at: 1 put: 1.
	slotsOfNoEffect at: 2 put: 3.
	slotsOfNoEffect at: 3 put: 4.
	slotsOfNoEffect at: 4 put: 5.
	slotsOfNoEffect at: 5 put: 6.
	slotsOfWormholes := Array new: 1.
	slotsOfWormholes at: 1 put: 6.
	noPowerUps := Array new: 1.
	aCustomLayout at: 'noEffect' put: slotsOfNoEffect.
	aCustomLayout at: 'wormholes' put: slotsOfWormholes.
	aCustomLayout at: 'speedUps' put: noPowerUps.
	aCustomLayout at: 'moonWalks' put: noPowerUps.
	aCustomLayout at: 'hyperJumps' put: noPowerUps.
	aCustomLayout at: 'atomicBombs' put: noPowerUps.
	
	
	expectedPositions := Dictionary new.
	expectedSlotAndLapOne := Array new: 2.
	expectedSlotAndLapTwo := Array new: 2.
	
	expectedSlotAndLapOne at: 1 put: 2.
	expectedSlotAndLapOne at: 2 put: 0.

	expectedSlotAndLapTwo at: 1 put: 0.
	expectedSlotAndLapTwo at: 2 put: 0.
	
	expectedPositions at: 1 put: expectedSlotAndLapOne.
	expectedPositions at: 2 put: expectedSlotAndLapTwo.
	
	aDice := LoadedDie with: 6 loadedWith: 6.
	aBoard := Board withCustomLayout: aCustomLayout andNumberOfSlots: 8.
	aGame := Game
		         withDice: aDice
		         withBoard: aBoard
		         andAmountOfLaps: 1
		         withAmountOfSpaceships: 2.
	aGame playNextTurn.
	self assert: aGame spaceshipPositioning equals: expectedPositions.
]
