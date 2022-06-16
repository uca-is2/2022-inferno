Class {
	#name : #HandTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
HandTest >> test01AHandIsInitializedWithTwoCards [
	| aHand exampleCardOne exampleCardTwo |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aHand := Hand containing: ({ exampleCardOne. exampleCardTwo }).
	self assert: (aHand cardsOnHand = 2 ).
]

{ #category : #'as yet unclassified' }
HandTest >> test02AHandAddsOneCardToADeckOfTwo [
	| aHand exampleCardOne exampleCardTwo cardToAdd |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aHand := Hand containing: ({ exampleCardOne. exampleCardTwo }).
	cardToAdd := SpeedCard new.
	aHand grabOne: cardToAdd.
	self assert: (aHand cardsOnHand = 3 ).
]

{ #category : #tests }
HandTest >> test03CardIsRemovedFromHandWhenPlayed [
	| aHand exampleCardOne exampleCardTwo cardToPlay |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aHand := Hand containing: ({ exampleCardOne. exampleCardTwo }).
	cardToPlay := SpeedCard new.
	aHand playCardOfType: cardToPlay.
	aHand playCardOfType: cardToPlay.
	self assert: (aHand cardsOnHand = 1 ).
]

{ #category : #tests }
HandTest >> test04AHandCanReturnACardThatIsPresentInThatDeck [
	| aHand testHand exampleCardOne exampleCardTwo typeOfCardToTake |
	testHand := Array new: 2.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	testHand at: 1 put: exampleCardOne.
	testHand at: 2 put: exampleCardTwo.
	typeOfCardToTake := SpeedCard new.
	aHand := Hand containing: ({ exampleCardOne. exampleCardTwo }).
	self assert: ((aHand playCardOfType: typeOfCardToTake) = exampleCardOne).
]
