"
I represent a Game that has dice, a board and amount of spaceships
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'board',
		'isGameFinished',
		'spaceshipsPositions',
		'currentSpaceshipID',
		'numberOfLaps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> withDice: aDice withBoard: aBoard andAmountOfLaps: aNumberOfLaps withAmountOfSpaceships: aNumberOfSpaceships [

	aNumberOfSpaceships > 1 ifFalse: [ 
		Error signal:
			'A game cannot be created with a number of spaceships lower than two.' ].

	(aDice isKindOf: DiceCup) | (aDice isKindOf: Die) ifFalse: [ 
		Error signal: 'A game cannot be created without dice.' ].

	(aBoard isKindOf: Board) ifFalse: [ 
		Error signal: 'A game cannot be created without a board.' ].
	
	(aNumberOfLaps isInteger) ifFalse: [ 
		Error signal: 'A game cannot be created without a valid amount of laps.' ].

	^ self new
		  initializeWithDice: aDice
		  withBoard: aBoard
		  andAmountOfLaps: aNumberOfLaps 
		  withAmountOfSpaceships: aNumberOfSpaceships
]

{ #category : #effects }
Game >> applyAtomicBomb [
	1 to: (spaceshipsPositions size) do: [:spaceshipIterator |  
		spaceshipsPositions at: spaceshipIterator at: 1 put:1.
		]
]

{ #category : #effects }
Game >> applyHyperJump [

	| lapBeforeEffect positionBeforeEffect slotsForThisHyperJump |
	slotsForThisHyperJump := board hyperJumpDistanceInSlots.
	lapBeforeEffect := self currentSpaceshipLap.
	positionBeforeEffect := self currentSpaceshipPosition.
	(self
		 isLapFinishedIf: positionBeforeEffect
		 moves: slotsForThisHyperJump)
		ifTrue: [ 
			lapBeforeEffect + 1 >= numberOfLaps
				ifTrue: [ self speshipMovesToTheEnd ]
				ifFalse: [ 
					self
						spaceshipMovesToSlot:
						positionBeforeEffect + slotsForThisHyperJump - board lenght
						andLap: lapBeforeEffect + 1 ] ]
		ifFalse: [ 
			self spaceshipMovesToSlot:
				positionBeforeEffect + slotsForThisHyperJump ]
]

{ #category : #effects }
Game >> applyMoonWalk [

	| lapBeforeEffect positionBeforeEffect nOfMoonwalkSlot |
	nOfMoonwalkSlot := board slotsForMoonwalk: (self currentSpaceshipPosition).
	1 to: spaceshipsPositions size do: [ :spaceshipIterator | 
		(spaceshipIterator = currentSpaceshipID) 
			ifFalse: [ 
				lapBeforeEffect := spaceshipsPositions at: spaceshipIterator at: 2.
				positionBeforeEffect := spaceshipsPositions
					                        at: spaceshipIterator
					                        at: 1.
				lapBeforeEffect = 0
					ifTrue: [ 
						positionBeforeEffect - nOfMoonwalkSlot < 1
							ifTrue: [ 
							spaceshipsPositions at: spaceshipIterator at: 1 put: 1 ]
							ifFalse: [ 
								spaceshipsPositions
									at: spaceshipIterator
									at: 1
									put: positionBeforeEffect - nOfMoonwalkSlot ] ]
					ifFalse: [ 
						positionBeforeEffect - nOfMoonwalkSlot < 1 ifTrue: [ 
							spaceshipsPositions
								at: spaceshipIterator
								at: 2
								put: lapBeforeEffect - 1.
							spaceshipsPositions
								at: spaceshipIterator
								at: 1
								put: positionBeforeEffect + board lenght - nOfMoonwalkSlot ] 
							ifFalse: [ 
								spaceshipsPositions
									at: spaceshipIterator
									at: 1
									put: positionBeforeEffect - nOfMoonwalkSlot ]
							] ] ]
]

{ #category : #effects }
Game >> applySpeedUp [

	| lapBeforeEffect positionBeforeEffect |
	lapBeforeEffect := self currentSpaceshipLap.
	positionBeforeEffect := self currentSpaceshipPosition.
	(self isLapFinishedIf: positionBeforeEffect moves: 4)
		ifTrue: [ 
			lapBeforeEffect + 1 >= numberOfLaps
				ifTrue: [ self speshipMovesToTheEnd ]
				ifFalse: [ 
					self
						spaceshipMovesToSlot: positionBeforeEffect + 4 - board lenght
						andLap: lapBeforeEffect + 1 ] ]
		ifFalse: [ self spaceshipMovesToSlot: positionBeforeEffect + 4 ]
]

{ #category : #effects }
Game >> applyWormhole [

	| lapBeforeEffect positionBeforeEffect |
	lapBeforeEffect := self currentSpaceshipLap.
	positionBeforeEffect := self currentSpaceshipPosition.
	lapBeforeEffect = 0
		ifTrue: [ 
			positionBeforeEffect - 4 < 1
				ifTrue: [ self spaceshipMovesToSlot: 1 ]
				ifFalse: [ self spaceshipMovesToSlot: positionBeforeEffect - 4 ] ]
		ifFalse: [ 
			positionBeforeEffect - 4 < 1 ifTrue: [ 
				self
					spaceshipMovesToSlot: positionBeforeEffect + board lenght - 4
					andLap: lapBeforeEffect - 1 ] ]
]

{ #category : #playing }
Game >> checkEffect [

	| effectOfSlot |
	effectOfSlot := board effectAt: self currentSpaceshipPosition.
	effectOfSlot = 'speedUps' ifTrue: [ self applySpeedUp ].
	effectOfSlot = 'wormholes' ifTrue: [ self applyWormhole ].
	effectOfSlot = 'moonWalks' ifTrue: [ self applyMoonWalk ].
	effectOfSlot = 'hyperJumps' ifTrue: [ self applyHyperJump ].
	effectOfSlot = 'atomicBombs' ifTrue: [ self applyAtomicBomb ]
]

{ #category : #accessing }
Game >> currentSpaceshipLap [
	^ spaceshipsPositions at: currentSpaceshipID at: 2
]

{ #category : #accessing }
Game >> currentSpaceshipPosition [
	^ spaceshipsPositions at: currentSpaceshipID  at: 1
]

{ #category : #accessing }
Game >> hasGameFinished [
	^ isGameFinished.
]

{ #category : #initialization }
Game >> initializeWithDice: aDice withBoard: aBoard andAmountOfLaps: aNumberOfLaps withAmountOfSpaceships: aNumberOfSpaceships [

	spaceshipsPositions := Dictionary new.
	1 to: aNumberOfSpaceships do: [ :spaceshipID | 
	spaceshipsPositions at: spaceshipID put: (Array new: 2).
	spaceshipsPositions at: spaceshipID at: 1 put: 0.
	spaceshipsPositions at: spaceshipID at: 2 put: 0.].
	currentSpaceshipID := 1.
	dice := aDice.
	board := aBoard.
	numberOfLaps := aNumberOfLaps.
	isGameFinished := false
]

{ #category : #movement }
Game >> isLapFinishedIf: positionBeforeRoll moves: rollNumber [

	^ positionBeforeRoll + rollNumber >= board lenght
]

{ #category : #movement }
Game >> move: aSpaceshipID [

	| positionBeforeRoll lapBeforeRoll rollNumber |
	positionBeforeRoll := self currentSpaceshipPosition.
	lapBeforeRoll := self currentSpaceshipLap.
	rollNumber := dice roll.
	(self isLapFinishedIf: positionBeforeRoll moves: rollNumber)
		ifTrue: [ 
			lapBeforeRoll + 1 >= numberOfLaps
				ifTrue: [ self speshipMovesToTheEnd ]
				ifFalse: [ 
					self spaceshipMovesToSlot: (positionBeforeRoll + rollNumber - board lenght) andLap:(lapBeforeRoll + 1).
					self checkEffect ] ]
		ifFalse: [ 
			self spaceshipMovesToSlot: ( positionBeforeRoll + rollNumber).
			self checkEffect ]
]

{ #category : #iteration }
Game >> nextSpaceshipInLine [

	currentSpaceshipID := currentSpaceshipID + 1.
	currentSpaceshipID > spaceshipsPositions size ifTrue: [ 
		currentSpaceshipID := 1 ]
]

{ #category : #playing }
Game >> playEntireGame [

	[ isGameFinished ] whileFalse: [ self playNextTurn ].
	^ spaceshipsPositions
]

{ #category : #playingByTurns }
Game >> playNextTurn [

	isGameFinished ifTrue: [ 
		Error signal: 'Game is finished! You cannot keep playing this game.' ].
	isGameFinished ifFalse: [ self move: currentSpaceshipID ].
	self currentSpaceshipPosition >= board lenght
	& (self currentSpaceshipLap >= numberOfLaps) ifTrue: [ 
		isGameFinished := true ].
	self nextSpaceshipInLine
]

{ #category : #playing }
Game >> spaceshipMovesToSlot: spaceshipNewPosition [

	spaceshipsPositions
		at: currentSpaceshipID
		at: 1
		put: spaceshipNewPosition
]

{ #category : #playing }
Game >> spaceshipMovesToSlot: spaceshipNewPosition andLap: spaceshipNewLap [

	spaceshipsPositions
		at: currentSpaceshipID
		at: 1
		put: spaceshipNewPosition.
	spaceshipsPositions at: currentSpaceshipID at: 2 put: spaceshipNewLap
]

{ #category : #movement }
Game >> speshipMovesToTheEnd [

	spaceshipsPositions at: currentSpaceshipID at: 2 put: numberOfLaps.
	spaceshipsPositions at: currentSpaceshipID at: 1 put: board lenght
]
