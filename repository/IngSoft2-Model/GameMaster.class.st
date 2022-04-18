Class {
	#name : #GameMaster,
	#superclass : #Object,
	#classVars : [
		'GameBoard',
		'GameDiceCup',
		'Players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
GameMaster class >> gameHasFinished [
	| weHaveAWinner amoutOfPlayers |
	weHaveAWinner := false.
	amoutOfPlayers := Players size.
	1 to: amoutOfPlayers do: [ :i | ((Players at: i) = GameBoard boardLength) ifTrue: [weHaveAWinner := true]].
	^ weHaveAWinner.
]

{ #category : #testing }
GameMaster class >> hasBoard [
	^GameBoard isValid.
]

{ #category : #testing }
GameMaster class >> hasDiceCup [
	^GameDiceCup isValid.
	
]

{ #category : #testing }
GameMaster class >> hasGame [
	^true.
]

{ #category : #testing }
GameMaster class >> hasThreePlayers [
	^(Players size = 3).
]

{ #category : #'as yet unclassified' }
GameMaster class >> movePlayer: playerID [ 
	| positionBeforeRoll winner rollNumber|
	winner:= false.
	positionBeforeRoll := Players at: playerID.
	rollNumber := GameDiceCup  roll.
	((positionBeforeRoll + rollNumber) >= GameBoard boardLength) ifTrue: [ winner := true ].
	Players at: playerID put: (positionBeforeRoll+rollNumber).
	^winner.
]

{ #category : #'as yet unclassified' }
GameMaster class >> movePlayer: playerID and: rollNumber [
	| positionBeforeRoll winner|
	winner:= false.
	positionBeforeRoll := Players at: playerID.
	(((positionBeforeRoll + rollNumber) >= GameBoard boardLength))
	ifTrue:[ (winner := true). Players at: playerID put: GameBoard boardLength]
	ifFalse: [Players at: playerID put: (positionBeforeRoll+rollNumber)].	
	^winner.
]

{ #category : #'instance creation' }
GameMaster class >> newBoard: aNumberOfSlots [ 
	GameBoard := (Board with: aNumberOfSlots ).
	
]

{ #category : #'instance creation' }
GameMaster class >> newDiceCup: aNumberOfSides [
	GameDiceCup := (DiceCup witAll: aNumberOfSides).
	
]

{ #category : #'as yet unclassified' }
GameMaster class >> playGame [

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

{ #category : #'as yet unclassified' }
GameMaster class >> playingWith: amountOfPlayers [
	Players := Dictionary new.
	1 to: amountOfPlayers do: [ :i | Players at: i put: 0 ].
]

{ #category : #'as yet unclassified' }
GameMaster class >> positionsAfterFinishIsValid: finishingPositions [ 
	|amountOfPlayers validation|
	validation := true.
	amountOfPlayers := Players size.
	(amountOfPlayers = finishingPositions size) ifFalse: [validation := false].
	1 to: amountOfPlayers do: [ :i | (finishingPositions at: i)<(-1) ifTrue: [validation := false ]].
	^validation.
]

{ #category : #'as yet unclassified' }
GameMaster class >> showPositions [
	|positions amountOfPlayers|
	amountOfPlayers := Players size.
	positions:= Array new: amountOfPlayers.
	1 to: amountOfPlayers do: [:i | positions at: i put: (Players at: i)].
	^positions.
]

{ #category : #'as yet unclassified' }
GameMaster class >> showTheWinner [
	|amountOfPlayers|
	amountOfPlayers := Players size.
	1 to: amountOfPlayers do: [:i | ((Players at: i)= (GameBoard boardLength)) ifTrue: [^i]].
]
