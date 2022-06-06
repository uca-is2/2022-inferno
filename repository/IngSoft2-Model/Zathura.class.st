"
i represent a game called zathura. with spaceships, a board, and dice
"
Class {
	#name : #Zathura,
	#superclass : #Object,
	#instVars : [
		'spaceshipsPositions',
		'dice',
		'board',
		'laps',
		'gameIsFinished'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Zathura class >> playedWith: aDice over: aBoard around: anAmountOfLaps by: anAmountOfSpaceships [

	anAmountOfSpaceships > 1 ifFalse: [ 
		Error signal:
			'A game cannot be created with a number of spaceships lower than two.' ].
		
	(anAmountOfLaps > 1) ifFalse: [ 
		Error signal: 'A game cannot be created without a valid amount of laps.' ].
	
	^ self new initializeGameWith: aDice playedOver: aBoard around: anAmountOfLaps by: anAmountOfSpaceships.
	
]

{ #category : #initialization }
Zathura >> initializeGameWith: aDice playedOver: aBoard around: anAmountOfLaps by: anAmountOfSpaceships [ 
	
	spaceshipsPositions := GamePositions with: anAmountOfSpaceships.
	dice := aDice .
	board := aBoard.
	laps := anAmountOfLaps.
	gameIsFinished := false.
	
]
