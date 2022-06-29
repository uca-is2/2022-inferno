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

{ #category : #tests }
HandTest >> test02ACardCanBeAddedToAHand [

	| aHand exampleCardOne exampleCardTwo cardToAdd |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aHand := Hand containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	cardToAdd := AccelerationCard new.
	aHand addPickedCardToHand: cardToAdd.
	self assert: aHand cardsOnHand equals: 3.
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

{ #category : #tests }
HandTest >> test05AnObjectIsNotAddedToHandUnlessItIsACard [

	| aHand exampleCardOne exampleCardTwo cardToAdd aCollectionOfSpots firstSpot secondSpot thirdSpot fourthSpot fifthSpot sixthSpot aCollectionOfSpaceships |
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	aHand := Hand containing: { 
			         exampleCardOne.
			         exampleCardTwo }.
	firstSpot := Spot createWith: NoEffect new.
	secondSpot := Spot createWith: SpeedUp new.
	thirdSpot := Spot createWith: NoEffect new.
	fourthSpot := Spot createWith: NoEffect new.
	fifthSpot := Spot createWith: NoEffect new.
	sixthSpot := Spot createWith: SpeedUp new.

	aCollectionOfSpots := { 
		                      firstSpot.
		                      secondSpot.
		                      thirdSpot.
		                      fourthSpot.
		                      fifthSpot.
		                      sixthSpot }.
	aCollectionOfSpaceships := { 'testShipOne'. 'testShipTwo' }.
	cardToAdd := Board with: aCollectionOfSpots and: 100 playedFor: 3 by: aCollectionOfSpaceships.
	aHand addPickedCardToHand: cardToAdd.
	self assert: aHand cardsOnHand equals: 2.
]
