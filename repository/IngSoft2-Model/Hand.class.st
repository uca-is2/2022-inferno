"
i represent a hand. a collection of cards owned by a specific spaceship in zathura game
"
Class {
	#name : #Hand,
	#superclass : #Object,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Hand class >> assertThatCollectionIsAllCards: aCollectionOfCards [

	| flag |
	flag := true.
	aCollectionOfCards do: [ :card | 
		card assertThatIsACard ifFalse: [ flag := false ] ].
	flag ifFalse: [ 
		Error signal:
			'Cant have a hand containing anything but a type of card.' ]
]

{ #category : #'class initialization' }
Hand class >> containing: aCollectionOfCards [

	self assertThatCollectionIsAllCards: aCollectionOfCards.
	^ self new initializeHandContaining: aCollectionOfCards
]

{ #category : #getter }
Hand >> cardsOnHand [

	^ deck size
]

{ #category : #playind }
Hand >> grabOne: aCard [

	aCard ifNotNil: [ deck addLast: aCard ]
]

{ #category : #initialization }
Hand >> initializeHandContaining: aCollectionOfCards [

	deck := OrderedCollection new.
	deck addAllFirst: aCollectionOfCards
]

{ #category : #playing }
Hand >> playCardOfType: aCard [

	| cardToPlay cardNumber |
	cardToPlay := nil.
	cardNumber := 1.
	[ cardNumber < (self cardsOnHand + 1) ] whileTrue: [ 
		aCard = (deck at: cardNumber) ifTrue: [ 
			cardToPlay := deck at: cardNumber.
			deck removeAt: cardNumber.
			cardNumber := self cardsOnHand ].
		cardNumber := cardNumber + 1 ].
	"hacer bien el error"
	cardToPlay ifNil: [ 
		Error signal: 'Spaceship does not have a card of that type' ].
	^ cardToPlay
]

{ #category : #gettesr }
Hand >> showHand [
	^ deck   
]

{ #category : #getters }
Hand >> take: aSpeedCard [

	^ deck remove: aSpeedCard
]
