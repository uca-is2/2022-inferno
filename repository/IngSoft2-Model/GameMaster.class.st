Class {
	#name : #GameMaster,
	#superclass : #Object,
	#classVars : [
		'CurrentPlayerId',
		'GameBoard',
		'GameDiceCup',
		'IsGameFinished',
		'Players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameMaster class >> newGameMaster [
	^self new initializeGameMaster.
]

{ #category : #showing }
GameMaster >> gameHasFinished [
	| weHaveAWinner amoutOfPlayers |
	weHaveAWinner := false.
	amoutOfPlayers := Players size.
	1 to: amoutOfPlayers do: [ :i | ((Players at: i) = GameBoard boardLength) ifTrue: [weHaveAWinner := true]].
	^ weHaveAWinner.
]

{ #category : #testing }
GameMaster >> hasBoard [
	^GameBoard isValid.
]

{ #category : #testing }
GameMaster >> hasDiceCup [
	^GameDiceCup isValid.
	
]

{ #category : #testing }
GameMaster >> hasGame [
	^true.
]

{ #category : #testing }
GameMaster >> hasGameFinished [
	^IsGameFinished.
]

{ #category : #testing }
GameMaster >> hasThreePlayers [
	^(Players size = 3).
]

{ #category : #initialization }
GameMaster >> initializeGameMaster [
	IsGameFinished:=false.
	CurrentPlayerId:=1.
]

{ #category : #execution }
GameMaster >> movePlayer: playerID [

	| positionBeforeRoll winner rollNumber |
	winner := false.
	positionBeforeRoll := Players at: playerID.
	rollNumber := GameDiceCup roll.
	positionBeforeRoll + rollNumber >= GameBoard boardLength ifTrue: [ 
		winner := true.
		Players at: playerID put: GameBoard boardLength ].
	winner ifFalse: [ 
		Players at: playerID put: positionBeforeRoll + rollNumber ].
	^ winner
]

{ #category : #execution }
GameMaster >> movePlayer: playerID and: rollNumber [
	| positionBeforeRoll winner|
	winner:= false.
	positionBeforeRoll := Players at: playerID.
	(((positionBeforeRoll + rollNumber) >= GameBoard boardLength))
	ifTrue:[ (winner := true). Players at: playerID put: GameBoard boardLength]
	ifFalse: [Players at: playerID put: (positionBeforeRoll+rollNumber)].	
	^winner.
]

{ #category : #'instance creation' }
GameMaster >> newBoard: aNumberOfSlots [ 
	GameBoard := (Board with: aNumberOfSlots ).
	
]

{ #category : #'instance creation' }
GameMaster >> newDiceCup: aNumberOfSides [
	GameDiceCup := (DiceCup witAll: aNumberOfSides).
	
]

{ #category : #'instance creation' }
GameMaster >> newLoadedDiceCup: aNumberOfLoadedSides [

	GameDiceCup := (DiceCup witAllLoaded: aNumberOfLoadedSides).
]

{ #category : #execution }
GameMaster >> nextInLine [
	CurrentPlayerId:=CurrentPlayerId + 1.
	(CurrentPlayerId > Players size) ifTrue: [ CurrentPlayerId :=1 ].
	
	
]

{ #category : #execution }
GameMaster >> playGame [

	| aPlayerFinished amountOfPlayers rollNumber i |
	aPlayerFinished := false.
	i :=1.
	amountOfPlayers := Players size.
	[ aPlayerFinished] whileFalse: [  
			rollNumber := GameDiceCup roll.
			aPlayerFinished := self movePlayer: i and: rollNumber.
			(i+1 > amountOfPlayers)
			ifTrue: [i:=1]
			ifFalse: [i:=i+1 ]].
]

{ #category : #execution }
GameMaster >> playNextTurn [
	( IsGameFinished) ifFalse: [ IsGameFinished :=self movePlayer: CurrentPlayerId ].
	( IsGameFinished) ifTrue:  [ Error signal: 'Game has already finished, you can not keep playing'].
	self nextInLine.
]

{ #category : #testing }
GameMaster >> playerOneHasMovedSpots: anInteger [ 
 	^((Players at: 1)=anInteger).
]

{ #category : #execution }
GameMaster >> playingWith: amountOfPlayers [
	Players := Dictionary new.
	1 to: amountOfPlayers do: [ :i | Players at: i put: 0 ].
]

{ #category : #testing }
GameMaster >> positionsAfterFinishIsValid: finishingPositions [ 
	|amountOfPlayers validation|
	validation := true.
	amountOfPlayers := Players size.
	(amountOfPlayers = finishingPositions size) ifFalse: [validation := false].
	1 to: amountOfPlayers do: [ :i | (finishingPositions at: i)<(-1) ifTrue: [validation := false ]].
	^validation.
]

{ #category : #showing }
GameMaster >> showPositions [
	|positions amountOfPlayers|
	amountOfPlayers := Players size.
	positions:= Array new: amountOfPlayers.
	1 to: amountOfPlayers do: [:i | positions at: i put: (Players at: i)].
	^positions.
]

{ #category : #showing }
GameMaster >> showTheWinner [
	|amountOfPlayers|
	amountOfPlayers := Players size.
	1 to: amountOfPlayers do: [:i | ((Players at: i)= (GameBoard boardLength)) ifTrue: [^i]].
]
