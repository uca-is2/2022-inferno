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

{ #category : #cardApplying }
Zathura >> applierFor: aCard by: aSpaceship [

	(self assertThatIsOfTypeAcceleration: aCard) ifTrue: [ 
		self currentSpaceshipPlaysCard: aCard playedBy: aSpaceship ]
]

{ #category : #cardApplying }
Zathura >> applierFor: aCard to: affectedSpaceship by: aSpaceship [

	(self assertThatIsOverloadOrSpeed: aCard) ifTrue: [ 
		self
			currentSpaceshipPlaysCard: aCard
			applyTo: affectedSpaceship
			playedBy: aSpaceship ].

	(self assertThatIsCancellationCard: aCard) ifTrue: [ 
		self
			cancelCard: (affectedSpaceship at: 2)
			from: (affectedSpaceship at: 1)
			playedBy: aSpaceship ].
		
	(self assertThatIsRepeatCard: aCard) ifTrue: [ 
		self repeatEffectCardPlayedBy: aSpaceship applyTo: affectedSpaceship ]
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

{ #category : #assertions }
Zathura >> assertThatIsCancellationCard: aCard [

	^ aCard = CancellationCard new
]

{ #category : #assertions }
Zathura >> assertThatIsOfTypeAcceleration: aCard [

	^ aCard = AccelerationCard new
]

{ #category : #assertions }
Zathura >> assertThatIsOverloadOrSpeed: aCard [

	^ aCard = OverloadCard new | (aCard = SpeedCard new)
]

{ #category : #assertions }
Zathura >> assertThatIsRedoCard: aCard [

	^ aCard = RedoCard new
]

{ #category : #assertions }
Zathura >> assertThatIsRepeatCard: aCard [

	^ aCard = RepeatCard new
]

{ #category : #assertions }
Zathura >> assertThatIsValidCardType: aCard [

	((self assertThatIsOverloadOrSpeed: aCard) or: ((self assertThatIsOfTypeAcceleration: aCard) or: ((self assertThatIsCancellationCard: aCard) or: ((self assertThatIsRepeatCard: aCard)or: (self assertThatIsRedoCard: aCard))))) ifFalse: [ 
		Error signal: 'no existe ese tipo de carta' ]
]

{ #category : #cardApplying }
Zathura >> cancelCard: aCard from: aSpaceship playedBy: anotherSpaceship [

	| cancelCard |
	self assert: aCard isBeingAppliedTo: aSpaceship.
	cancelCard := CancellationCard new.
	(spaceshipHands at: anotherSpaceship) playCardOfType: cancelCard.
	(cardsBeingApplied at: aSpaceship) remove: aCard.
	lastCardPlayed := cancelCard
]

{ #category : #cardApplying }
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

{ #category : #cardApplying }
Zathura >> cardRedoerWith: aCard to: affectedSpaceship by: aSpaceship [

	(self assertThatIsRedoCard: aCard) ifFalse: [ ^ self ].
	(self assertThatIsOverloadOrSpeed: lastCardPlayed) ifTrue: [ 
		self redoLastCardPlayedBy: aSpaceship applyTo: affectedSpaceship ].
	(self assertThatIsOfTypeAcceleration: lastCardPlayed) ifTrue: [ 
		self redoLastCardPlayedBy: aSpaceship ].
	(self assertThatIsCancellationCard: lastCardPlayed) ifTrue: [ 
		self
			redoCancelationCard: (affectedSpaceship at: 2)
			from: (affectedSpaceship at: 1)
			PlayedBy: aSpaceship ].
	(self assertThatIsRepeatCard: lastCardPlayed) ifTrue: [ 
		self redoRepeatCardPlayedBy: aSpaceship applyTo: affectedSpaceship ]
]

{ #category : #getters }
Zathura >> cardsBeingAppliedOn: aSpaceship [

	^ cardsBeingApplied at: aSpaceship.
]

{ #category : #cardApplying }
Zathura >> currentSpaceshipPlaysCard: aPermanentCard applyTo: aSpaceship playedBy: anotherSpaceship [

	| cardToApply |
	self assertSpaceshipCanPlayCard: anotherSpaceship.
	cardToApply := (spaceshipHands at: anotherSpaceship) playCardOfType:
		               aPermanentCard.
	(cardsBeingApplied at: aSpaceship) addLast: aPermanentCard.
	lastCardPlayed := cardToApply
]

{ #category : #cardApplying }
Zathura >> currentSpaceshipPlaysCard: anAcceleratorCard playedBy: aSpaceship [

	| cardToApply |
	self assertSpaceshipCanPlayCard: aSpaceship.
	self assertCorrectMethodForTypeOfCard: anAcceleratorCard.
	cardToApply := (spaceshipHands at: aSpaceship) playCardOfType:
		               anAcceleratorCard.
	(cardsBeingApplied at: 'General') addLast: anAcceleratorCard.
	lastCardPlayed := cardToApply
]

{ #category : #getters }
Zathura >> handOf: aSpaceship [

	^ spaceshipHands at: aSpaceship
]

{ #category : #getters }
Zathura >> hasGameFinished [

	^ gameIsFinished
]

{ #category : #assertions }
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

	self applierFor: aCard to: affectedSpaceship by: aSpaceship.
	self applierFor: aCard by: aSpaceship.
	self cardRedoerWith: aCard to: affectedSpaceship by: aSpaceship.
	self assertThatIsValidCardType: aCard
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

	| positionBeforeRoll rollNumber cardsEffectsOnRoll pickedCard |
	self assertItIsThatSpaceshipsTurn: aSpaceship.
	positionBeforeRoll := board positionOf: aSpaceship.
	rollNumber := dice roll.
	cardsEffectsOnRoll := self cardApplicator.
	pickedCard := board
		              move: aSpaceship
		              from: positionBeforeRoll
		              to: rollNumber + cardsEffectsOnRoll.
	(spaceshipHands at: aSpaceship) addPickedCardToHand: pickedCard.
	self hasItReachedTheFinishLine: aSpaceship.
	turnController nextSpaceshipInLine
]

{ #category : #getters }
Zathura >> positionOf: aSpaceship [

	^ board positionOf: aSpaceship
]

{ #category : #getters }
Zathura >> rankingOfSpaceships [

	^ board rankingOfSpaceships
]

{ #category : #cardApplying }
Zathura >> redoCancelationCard: aCard from: aSpaceship PlayedBy: anotherSpaceship [

	| redoCard |
	redoCard := RedoCard new.
	(spaceshipHands at: anotherSpaceship) playCardOfType: redoCard.
	(spaceshipHands at: anotherSpaceship) addPickedCardToHand: lastCardPlayed.
	self cancelCard: aCard from: aSpaceship playedBy: anotherSpaceship
]

{ #category : #cardApplying }
Zathura >> redoLastCardPlayedBy: aSpaceship [

	| redoCard |
	redoCard := RedoCard new.
	(spaceshipHands at: aSpaceship) playCardOfType: redoCard.
	self assertSpaceshipCanPlayCard: aSpaceship.
	(spaceshipHands at: aSpaceship) addPickedCardToHand: lastCardPlayed.
	self currentSpaceshipPlaysCard: lastCardPlayed playedBy: aSpaceship
]

{ #category : #cardApplying }
Zathura >> redoLastCardPlayedBy: aSpaceship applyTo: anotherSpaceship [

	| redoCard |
	redoCard := RedoCard new.
	(spaceshipHands at: anotherSpaceship) playCardOfType: redoCard.
	self assertSpaceshipCanPlayCard: aSpaceship.
	(spaceshipHands at: anotherSpaceship) addPickedCardToHand: lastCardPlayed.
	self
		currentSpaceshipPlaysCard: lastCardPlayed
		applyTo: anotherSpaceship
		playedBy: aSpaceship
]

{ #category : #cardApplying }
Zathura >> redoRepeatCardPlayedBy: aSpaceship applyTo: anotherSpaceship [

	| redoCard |
	redoCard := RedoCard new.
	(spaceshipHands at: aSpaceship) playCardOfType: redoCard.
	(spaceshipHands at: aSpaceship) addPickedCardToHand: lastCardPlayed.
	self repeatEffectCardPlayedBy: aSpaceship applyTo: anotherSpaceship
]

{ #category : #cardApplying }
Zathura >> repeatEffectCardPlayedBy: aSpaceship applyTo: anotherSpaceship [

	| repeatCard cardPicked |
	repeatCard := RepeatCard new.
	(spaceshipHands at: anotherSpaceship) playCardOfType: repeatCard.
	cardPicked := board applyLastEffectTo: anotherSpaceship.
	(spaceshipHands at: anotherSpaceship) addPickedCardToHand: cardPicked.
	lastCardPlayed := repeatCard
]

{ #category : #getters }
Zathura >> showCardsOnHandFor: aSpaceship [ 
	^(spaceshipHands at: aSpaceship) showHand.
]
