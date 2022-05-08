"
I represent a Game that has dice, a board and amount of spaceships
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'numberOfSpaceships',
		'dice',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> withDice: aDice withBoard: aBoard withAmountOfSpaceships: aNumberOfSpaceships [

	aNumberOfSpaceships > 1 ifFalse: [ 
		Error signal:
			'A game cannot be created with a number of spaceships lower than two.' ].

	(aDice isKindOf: DiceCup) | (aDice isKindOf: Die) ifFalse: [ 
		Error signal: 'A game cannot be created without dice.' ].

	(aBoard isKindOf: Board) ifFalse: [ 
		Error signal: 'A game cannot be created without a board.' ].

	^ self new
		  initializeWithDice: aDice
		  withBoard: aBoard
		  withAmountOfSpaceships: aNumberOfSpaceships
]

{ #category : #initialization }
Game >> initializeWithDice: aDice withBoard: aBoard withAmountOfSpaceships: aNumberOfSpaceships [
 
	numberOfSpaceships := aNumberOfSpaceships.
	dice := aDice .
	board := aBoard .
	
]
