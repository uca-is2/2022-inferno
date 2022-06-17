Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsTest >> test01SpeedCardCanRespondToAssertionIfItIsATypeOfCard [

	| aTestCard |
	aTestCard := SpeedCard new.
	self assert: aTestCard assertThatIsACard
]

{ #category : #tests }
CardsTest >> test02OverloadCardCanRespondToAssertionIfItIsATypeOfCard [

	| aTestCard |
	aTestCard := OverloadCard new.
	self assert: aTestCard assertThatIsACard
]

{ #category : #tests }
CardsTest >> test03AccelerationCardCanRespondToAssertionIfItIsATypeOfCard [

	| aTestCard |
	aTestCard := AccelerationCard new.
	self assert: aTestCard assertThatIsACard
]

{ #category : #tests }
CardsTest >> test04CancellationCardCanRespondToAssertionIfItIsATypeOfCard [

	| aTestCard |
	aTestCard := CancellationCard new.
	self assert: aTestCard assertThatIsACard
]

{ #category : #tests }
CardsTest >> test05RedoCardCanRespondToAssertionIfItIsATypeOfCard [

	| aTestCard |
	aTestCard := RedoCard new.
	self assert: aTestCard assertThatIsACard
]

{ #category : #tests }
CardsTest >> test06RepeatCardCanRespondToAssertionIfItIsATypeOfCard [

	| aTestCard |
	aTestCard := RepeatCard new.
	self assert: aTestCard assertThatIsACard
]

{ #category : #tests }
CardsTest >> test07SpeedCardCanTellIfACardIsOfSameType [

	| aTestCard aCard |
	aTestCard := SpeedCard new.
	aCard := SpeedCard new.
	self assert: aTestCard equals: aCard
]

{ #category : #tests }
CardsTest >> test08OverloadCardCanTellIfACardIsOfSameType [

	| aTestCard aCard |
	aTestCard := OverloadCard new.
	aCard := OverloadCard new.
	self assert: aTestCard equals: aCard
]

{ #category : #tests }
CardsTest >> test09AccelerationCardCanTellIfACardIsOfSameType [

	| aTestCard aCard |
	aTestCard := AccelerationCard new.
	aCard := AccelerationCard new.
	self assert: aTestCard equals: aCard
]

{ #category : #tests }
CardsTest >> test10CancellationCardCanTellIfACardIsOfSameType [

	| aTestCard aCard |
	aTestCard := CancellationCard new.
	aCard := CancellationCard new.
	self assert: aTestCard equals: aCard
]

{ #category : #tests }
CardsTest >> test11RedoCardCanTellIfACardIsOfSameType [

	| aTestCard aCard |
	aTestCard := RedoCard new.
	aCard := RedoCard new.
	self assert: aTestCard equals: aCard
]

{ #category : #tests }
CardsTest >> test12RepeatCardCanTellIfACardIsOfSameType [

	| aTestCard aCard |
	aTestCard := RepeatCard new.
	aCard := RepeatCard new.
	self assert: aTestCard equals: aCard
]
