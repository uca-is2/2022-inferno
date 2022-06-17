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
	aHand := Hand containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	self assert: aHand cardsOnHand equals: 2
]

{ #category : #accessing }
HandTest >> test02AHandAddsOneCardToADeckOfTwo [

	| aHand exampleCardOne exampleCardTwo cardToAdd |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aHand := Hand containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	cardToAdd := SpeedCard new.
	aHand grabOne: cardToAdd.
	self assert: aHand cardsOnHand equals: 3
]

{ #category : #tests }
HandTest >> test03CardIsRemovedFromHandWhenPlayed [

	| aHand exampleCardOne exampleCardTwo cardToPlay |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aHand := Hand containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	cardToPlay := SpeedCard new.
	aHand playCardOfType: cardToPlay.
	self assert: aHand cardsOnHand equals: 1
]

{ #category : #tests }
HandTest >> test04AHandCanReturnACardThatIsPresentInThatDeck [

	| aHand testHand exampleCardOne exampleCardTwo typeOfCardToTake testCard |
	testHand := Array new: 2.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	testCard := SpeedCard new.
	testHand at: 1 put: exampleCardOne.
	testHand at: 2 put: exampleCardTwo.
	typeOfCardToTake := SpeedCard new.
	aHand := Hand containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	self
		assert: (aHand playCardOfType: typeOfCardToTake)
		equals: testCard
]
