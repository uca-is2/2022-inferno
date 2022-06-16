Class {
	#name : #HandTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
HandTest >> test01AHandCanReturnACardThatIsPresentInThatDeck [
	| aHand testHand exampleCardOne exampleCardTwo typeOfCardToTake |
	testHand := Array new: 2.
	exampleCardOne := SpeedCard new.
	exampleCardTwo := OverloadCard new.
	testHand at: 1 put: exampleCardOne.
	testHand at: 2 put: exampleCardTwo.
	typeOfCardToTake := SpeedCard new.
	aHand := Hand containing: ({ exampleCardOne. exampleCardTwo }).
	self assert: (aHand take: typeOfCardToTake) equals: exampleCardOne.
]
