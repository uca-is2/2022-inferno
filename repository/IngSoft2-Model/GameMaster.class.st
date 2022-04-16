Class {
	#name : #GameMaster,
	#superclass : #Object,
	#classVars : [
		'GameBoard',
		'Players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
GameMaster class >> gameHasFinished [
	| weHaveAWinner amoutOfPlayers |
	weHaveAWinner := false.
	amoutOfPlayers := Players size.
	1 to: amoutOfPlayers do: [ :i | ((Players at: i) >= 20) ifTrue: [weHaveAWinner := true]].
	^ weHaveAWinner.
]

{ #category : #testing }
GameMaster class >> hasBoard [
	^GameBoard isValid.
]

{ #category : #testing }
GameMaster class >> hasThreePlayers [
	^(Players size = 3).
]

{ #category : #'as yet unclassified' }
GameMaster class >> movePlayer: playerID [ 
	| positionBeforeRoll |
	positionBeforeRoll := Players at: playerID.
	Players at: playerID put: (positionBeforeRoll+7).
]

{ #category : #'instance creation' }
GameMaster class >> newBoard: aNumberOfSlots [ 
	GameBoard := (Board with: aNumberOfSlots ).
]

{ #category : #'as yet unclassified' }
GameMaster class >> playGame [
	| aPlayerFinished amountOfPlayers |
	aPlayerFinished := 0.
	amountOfPlayers := Players size.
	[ aPlayerFinished > 0 ] 
	whileFalse: [ 1 to: amountOfPlayers do: [:i | self movePlayer: i.
																 ((Players at: i) > 20)	ifTrue: [ aPlayerFinished := i ]]]
]

{ #category : #'as yet unclassified' }
GameMaster class >> playingWith: amountOfPlayers [
	Players := Dictionary new.
	1 to: amountOfPlayers do: [ :i | Players at: i put: 0 ].
]
