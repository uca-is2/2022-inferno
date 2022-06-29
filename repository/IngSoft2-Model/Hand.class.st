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

	aCollectionOfCards do: [ :card | 
		card assertThatIsACard ifFalse: [ Error signal: 'Cant have a hand containing anything but a type of card.' ] ].
]

{ #category : #'class initialization' }
Hand class >> containing: aCollectionOfCards [

	self assertThatCollectionIsAllCards: aCollectionOfCards.
	^ self new initializeContaining: aCollectionOfCards
]

{ #category : #playing }
Hand >> addPickedCardToHand: aCard [

	[aCard assertThatIsACard] on: Exception do: [ ^aCard ].

	deck addLast: aCard.
	^aCard
]

{ #category : #playing }
Hand >> assertCardIsOnHand: cardToPlay [

	cardToPlay ifNil: [ 
		Error signal: 'Spaceship does not have a card of that type' ]
]

{ #category : #getter }
Hand >> cardsOnHand [

	^ deck size
]

{ #category : #initialization }
Hand >> initializeContaining: aCollectionOfCards [

	deck := OrderedCollection new.
	deck addAllFirst: aCollectionOfCards.
	^self 
]

{ #category : #playing }
Hand >> playCardOfType: aCard [

	| cardToPlay |
	cardToPlay := nil.
	cardToPlay := deck
		              detect: [ :eachCard | aCard = eachCard ]
		              ifNone: [ nil ].
	deck remove: cardToPlay.
	self assertCardIsOnHand: cardToPlay.
	^ cardToPlay
]

{ #category : #getter }
Hand >> showHand [

	^ deck
]
