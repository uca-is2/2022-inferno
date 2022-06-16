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
		card assertThatIsACard ifFalse: [ 
			flag := false ] ].
	flag ifFalse: [ 
		Error signal:
			'Cant have a hand containing anything but a type of card.' ]
]

{ #category : #'class initialization' }
Hand class >> containing: aCollectionOfCards [

	self assertThatCollectionIsAllCards: aCollectionOfCards.
	^ self new initializeHandContaining: aCollectionOfCards
]

{ #category : #initialization }
Hand >> initializeHandContaining: aCollectionOfCards [ 
	deck := OrderedCollection new.
	deck addAllFirst: aCollectionOfCards.
]

{ #category : #getters }
Hand >> take: aSpeedCard [ 
	^ deck remove: aSpeedCard.
]
