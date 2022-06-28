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

{ #category : #asserting }
Zathura class >> assertAmountOfSpaceshipOn: aBoard matchesAmountOf: handsOfCards [

	handsOfCards size = aBoard spaceshipPositions size ifFalse: [ 
		Error signal:
			'Can not play with amount of hands different than amount of spaceships' ]
]

{ #category : #'class initialization' }
Zathura class >> playWith: aDiceCup over: aBoard dealing: aCollectionOfHands [

	self
		assertAmountOfSpaceshipOn: aBoard
		matchesAmountOf: aCollectionOfHands.
	self selfAssertEachPlayerHasTwoCardsAtTheBegining: aCollectionOfHands.
	^ self new
		  initializeWith: aDiceCup
		  over: aBoard
		  dealing: aCollectionOfHands
]

{ #category : #'class initialization' }
Zathura class >> selfAssertEachPlayerHasTwoCardsAtTheBegining: aCollectionOfHands [

	aCollectionOfHands do: [ :hand | 
		hand cardsOnHand = 2 ifFalse: [ 
			Error signal: 'All players should start with 2 cards' ] ]
]

{ #category : #assertions }
Zathura >> assert: aCard isBeingAppliedTo: aSpaceship [

	((cardsBeingApplied at: aSpaceship) includes: aCard) ifFalse: [ 
		Error signal:
			'there is no card of that type being applied to that spaceship' ]
]

{ #category : #assertions }
Zathura >> assertCorrectMethodForTypeOfCard: anAcceleratorCard [

	| acceleratorCard |
	acceleratorCard := AccelerationCard new.
	anAcceleratorCard = acceleratorCard ifFalse: [ 
		Error signal: 'Wrong method used, this is not an acceleration card' ]
]

{ #category : #assertions }
Zathura >> assertGameIsFinished [

	gameIsFinished ifTrue: [ 
		Error signal: 'Game is finished! You cannot keep playing this game.' ]
]

{ #category : #assertions }
Zathura >> assertItIsThatSpaceshipsTurn: aSpaceship [

	aSpaceship == turnController activeSpaceship ifFalse: [ 
		Error signal: 'Cannot play turn if it is not that spaceship turn.' ]
]

{ #category : #assertions }
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
	spaceshipHands := Dictionary new: (aBoard spaceshipPositions size).
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
Zathura >> play: aCard by: aSpaceship affecting: affectedSpaceship [ 
	((aCard =(OverloadCard new)) | (aCard = (SpeedCard new))) ifTrue: [ 
		self currentSpaceshipPlaysCard: aCard
		applyTo: affectedSpaceship
		playedBy: aSpaceship.
		 ]. 
	(aCard =(AccelerationCard new)) ifTrue: [ 
		self currentSpaceshipPlaysCard: aCard playedBy: aSpaceship.
		 ].
	(aCard =(CancellationCard new)) ifTrue: [ 
		self cancelCard: (affectedSpaceship at: 2) from: (affectedSpaceship at: 1) playedBy: aSpaceship
		 ].
	(aCard =(RepeatCard new)) ifTrue: [ 
		self repeatEffectCardPlayedBy: aSpaceship applyTo: affectedSpaceship.
		 ].
	(aCard =(RedoCard new)) ifTrue: [ 
		(lastCardPlayed = (AccelerationCard new)) ifTrue
		self redoLastCardPlayedBy: aSpaceship applyTo: affectedSpaceship.
		self redoLastCardPlayedBy: 'Razor Crest'.
		 ].
	
	((aCard =(OverloadCard new)) | (aCard = (SpeedCard new)) | (aCard =(AccelerationCard  new)) | (aCard =(CancellationCard new)) | (aCard =(RepeatCard new)) | (aCard =(RedoCard new))) ifFalse: [ 
		Error signal: 'no existe ese tipo de carta'
		 ]
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

	| positionBeforeRoll  rollNumber cardsEffectsOnRoll pickedCard |
	self assertItIsThatSpaceshipsTurn: aSpaceship.
	positionBeforeRoll := board positionOf: aSpaceship.
	rollNumber := dice roll.
	cardsEffectsOnRoll := self cardApplicator.
	pickedCard := board
		              move: aSpaceship
		              from: positionBeforeRoll 
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
