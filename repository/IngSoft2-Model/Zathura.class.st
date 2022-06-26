"
i represent a Zathura: Inferno game.
"
Class {
	#name : #Zathura,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice',
		'gameIsFinished',
		'turnController',
		'spaceshipHands',
		'cardsBeingApplied',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Zathura class >> playWith: aDiceCup over: aBoard dealing: handsOfCards [

	handsOfCards size = aBoard spaceshipPositions size ifFalse: [ 
		Error signal:
			'Can not play with amount of hands different than amount of spaceships' ].
		handsOfCards do: [ :hand |
			hand cardsOnHand = 2 ifFalse: [ 
			Error signal:
			'All players should start with 2 cards' ].
			 ].
	^ self new
		  initializeWith: aDiceCup
		  over: aBoard
		  dealing: handsOfCards
]

{ #category : #playing }
Zathura >> assert: aCard isBeingAppliedTo: aSpaceship [

	((cardsBeingApplied at: aSpaceship) includes: aCard) ifFalse: [ 
		Error signal:
			'there is no card of that type being applied to that spaceship' ]
]

{ #category : #playing }
Zathura >> assertCorrectMethodForTypeOfCard: anAcceleratorCard [

	| acceleratorCard |
	acceleratorCard := AccelerationCard new.
	anAcceleratorCard = acceleratorCard ifFalse: [ 
		Error signal: 'Wrong method used, this is not an acceleration card' ]
]

{ #category : #playing }
Zathura >> assertGameIsFinished [

	gameIsFinished ifTrue: [ 
		Error signal: 'Game is finished! You cannot keep playing this game.' ]
]

{ #category : #playing }
Zathura >> assertItIsThatSpaceshipsTurn: aSpaceship [

	aSpaceship == turnController activeSpaceship ifFalse: [ 
		Error signal: 'Cannot play turn if it is not that spaceship turn.' ]
]

{ #category : #playing }
Zathura >> assertSpaceshipCanPlayCard: aSpaceship [

	aSpaceship = turnController activeSpaceship ifFalse: [ 
		Error signal: 'Cannot play this card when it is not your turn' ]
]

{ #category : #playing }
Zathura >> cancelCard: aCard from: aSpaceship playedBy: anotherSpaceship [

	| cancelCard |
	self assert: aCard isBeingAppliedTo: aSpaceship.
	cancelCard := CancellationCard new.
	(spaceshipHands at: anotherSpaceship) playCardOfType: cancelCard.
	(cardsBeingApplied at: aSpaceship) remove: aCard.
	lastCardPlayed := cancelCard
]

{ #category : #playing }
Zathura >> cardApplicator [

	| cardsAffectingRoll cardsAffectingAllRolls addToRoll |
	cardsAffectingRoll := cardsBeingApplied at:
		                      turnController activeSpaceship.
	cardsAffectingAllRolls := cardsBeingApplied at: 'General'.
	cardsAffectingRoll addAllLast: cardsAffectingAllRolls.
	addToRoll := 0.
	cardsAffectingRoll do: [ :card | 
		addToRoll := addToRoll + card effectOnRoll ].
	^ addToRoll
]

{ #category : #playing }
Zathura >> currentSpaceshipPlaysCard: aPermanentCard applyTo: aSpaceship playedBy: anotherSpaceship [

	| cardToApply |
	self assertSpaceshipCanPlayCard: anotherSpaceship.
	cardToApply := (spaceshipHands at: anotherSpaceship) playCardOfType:
		               aPermanentCard.
	(cardsBeingApplied at: aSpaceship) addLast: aPermanentCard.
	lastCardPlayed := cardToApply
]

{ #category : #playing }
Zathura >> currentSpaceshipPlaysCard: anAcceleratorCard playedBy: aSpaceship [

	| cardToApply |
	self assertSpaceshipCanPlayCard: aSpaceship.
	self assertCorrectMethodForTypeOfCard: anAcceleratorCard.
	cardToApply := (spaceshipHands at: aSpaceship) playCardOfType:
		               anAcceleratorCard.
	(cardsBeingApplied at: 'General') addLast: anAcceleratorCard.
	lastCardPlayed := cardToApply
]

{ #category : #getter }
Zathura >> handOf: aSpaceship [

	^ spaceshipHands at: aSpaceship
]

{ #category : #getters }
Zathura >> hasGameFinished [

	^ gameIsFinished
]

{ #category : #playing }
Zathura >> hasItReachedTheFinishLine: currentSpaceship [

	(board positionOf: currentSpaceship) spotNumber
	>= board lengthInSpots
	&
	((board positionOf: currentSpaceship) lapNumber >= board amountOfLaps) 
		ifTrue: [ gameIsFinished := true ]
]

{ #category : #initialization }
Zathura >> initializeWith: aDiceCup over: aBoard dealing: handsOfCards [

	| spaceshipKeys |
	board := aBoard.
	dice := aDiceCup.
	gameIsFinished := false.
	turnController := TurnController with: aBoard spaceshipPositions.
	lastCardPlayed := CancellationCard new.
	spaceshipHands := Dictionary new: aBoard spaceshipPositions size.
	spaceshipKeys := aBoard spaceshipPositions keys.
	cardsBeingApplied := Dictionary new:
		                     aBoard spaceshipPositions size + 1.
	1 to: aBoard spaceshipPositions size do: [ :spaceship | 
		spaceshipHands
			at: (spaceshipKeys at: spaceship)
			put: (handsOfCards at: spaceship).
		cardsBeingApplied
			at: (spaceshipKeys at: spaceship)
			put: OrderedCollection new ].
	cardsBeingApplied at: 'General' put: OrderedCollection new
]

{ #category : #playing }
Zathura >> playNextTurn [

	| currentSpaceship |
	self assertGameIsFinished.
	currentSpaceship := turnController activeSpaceship.
	self playTurn: currentSpaceship
]

{ #category : #playing }
Zathura >> playTurn: aSpaceship [

	| positionBeforeRoll lapBeforeRoll spotBeforeRoll rollNumber cardsEffectsOnRoll pickedCard |
	self assertItIsThatSpaceshipsTurn: aSpaceship.
	positionBeforeRoll := board positionOf: aSpaceship.
	lapBeforeRoll := positionBeforeRoll lapNumber.
	spotBeforeRoll := positionBeforeRoll spotNumber.
	rollNumber := dice roll.
	cardsEffectsOnRoll := self cardApplicator.
	pickedCard := board
		              move: aSpaceship
		              fromSpot: spotBeforeRoll
		              andLap: lapBeforeRoll
		              to: rollNumber + cardsEffectsOnRoll.

	(spaceshipHands at: aSpaceship) grabOne: pickedCard.
	self hasItReachedTheFinishLine: aSpaceship.
	turnController nextSpaceshipInLine
]

{ #category : #getter }
Zathura >> positionOf: aSpaceship [

	^ board positionOf: aSpaceship
]

{ #category : #getter }
Zathura >> rankingOfSpaceships [

	^ board rankingOfSpaceships
]

{ #category : #playing }
Zathura >> redoCancelationCard: aCard from: aSpaceship PlayedBy: anotherSpaceship [

	| redoCard |
	redoCard := RedoCard new.
	(spaceshipHands at: anotherSpaceship) playCardOfType: redoCard.
	(spaceshipHands at: anotherSpaceship) grabOne: lastCardPlayed.
	self cancelCard: aCard from: aSpaceship playedBy: anotherSpaceship
]

{ #category : #playing }
Zathura >> redoLastCardPlayedBy: aSpaceship [

	| redoCard |
	redoCard := RedoCard new.
	(spaceshipHands at: aSpaceship) playCardOfType: redoCard.
	self assertSpaceshipCanPlayCard: aSpaceship.
	(spaceshipHands at: aSpaceship) grabOne: lastCardPlayed.
	self currentSpaceshipPlaysCard: lastCardPlayed playedBy: aSpaceship
]

{ #category : #playing }
Zathura >> redoLastCardPlayedBy: aSpaceship applyTo: anotherSpaceship [

	| redoCard |
	redoCard := RedoCard new.
	(spaceshipHands at: anotherSpaceship) playCardOfType: redoCard.
	self assertSpaceshipCanPlayCard: aSpaceship.
	(spaceshipHands at: anotherSpaceship) grabOne: lastCardPlayed.
	self
		currentSpaceshipPlaysCard: lastCardPlayed
		applyTo: anotherSpaceship
		playedBy: aSpaceship
]

{ #category : #playing }
Zathura >> redoRepeatCardPlayedBy: aSpaceship applyTo: anotherSpaceship [

	| redoCard |
	redoCard := RedoCard new.
	(spaceshipHands at: aSpaceship) playCardOfType: redoCard.
	(spaceshipHands at: aSpaceship) grabOne: lastCardPlayed.
	self repeatEffectCardPlayedBy: aSpaceship applyTo: anotherSpaceship
]

{ #category : #playing }
Zathura >> repeatEffectCardPlayedBy: aSpaceship applyTo: anotherSpaceship [

	| repeatCard cardPicked |
	repeatCard := RepeatCard new.
	(spaceshipHands at: anotherSpaceship) playCardOfType: repeatCard.
	cardPicked := board applyLastEffectTo: anotherSpaceship.
	(spaceshipHands at: anotherSpaceship) grabOne: cardPicked.
	lastCardPlayed := repeatCard
]

{ #category : #getters }
Zathura >> showCardsOnHandFor: aSpaceship [ 
	^(spaceshipHands at: aSpaceship) showHand.
]
