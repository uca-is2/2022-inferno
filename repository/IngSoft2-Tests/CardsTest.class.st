Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsTest >> test01SpeedCardCanRespondToAssertionMessage [

	| aTestCard |
	aTestCard := SpeedCard new.
	self assert: aTestCard assertThatIsACard
]

{ #category : #tests }
CardsTest >> test02SpeedCardEqualsAnotherInstanceOfSameCard [

	| aTestCard aCard |
	aTestCard := SpeedCard new.
	aCard := SpeedCard new.
	self assert: aTestCard equals: aCard
]

{ #category : #tests }
CardsTest >> test03SpeedCardEffectOnRollIsPlusOne [

	| aTestCard |
	aTestCard := SpeedCard new.
	self assert: aTestCard effectOnRoll equals: 1.
]

{ #category : #tests }
CardsTest >> test04OverloadCardCanRespondToAssertionMessage [

	| aTestCard |
	aTestCard := OverloadCard new.
	self assert: aTestCard assertThatIsACard
]

{ #category : #tests }
CardsTest >> test05OverloadCardEqualsAnotherInstanceOfSameCard [

	| aTestCard aCard |
	aTestCard := OverloadCard new.
	aCard := OverloadCard new.
	self assert: aTestCard equals: aCard
]

{ #category : #tests }
CardsTest >> test06OverloadEffectOnRollIsMinusTwo [

	| aTestCard |
	aTestCard := OverloadCard  new.
	self assert: aTestCard effectOnRoll equals: -2.
]

{ #category : #tests }
CardsTest >> test07CancellationCardCanRespondToAssertionMessage [

	| aTestCard |
	aTestCard := CancellationCard new.
	self assert: aTestCard assertThatIsACard
]

{ #category : #tests }
CardsTest >> test08CancellationCardEqualsAnotherInstanceOfSameCard [

	| aTestCard aCard |
	aTestCard := CancellationCard new.
	aCard := CancellationCard new.
	self assert: aTestCard equals: aCard
]

{ #category : #tests }
CardsTest >> test09AccelerationCardCanRespondToAssertionMessage [

	| aTestCard |
	aTestCard := AccelerationCard new.
	self assert: aTestCard assertThatIsACard
]

{ #category : #tests }
CardsTest >> test10AccelerationCardEqualsAnotherInstanceOfSameCard [

	| aTestCard aCard |
	aTestCard := AccelerationCard new.
	aCard := AccelerationCard new.
	self assert: aTestCard equals: aCard
]

{ #category : #tests }
CardsTest >> test11AccelerationCardEffectOnRollIsPlusOne [

	| aTestCard |
	aTestCard := AccelerationCard new.
	self assert: aTestCard effectOnRoll equals: 1.
]

{ #category : #tests }
CardsTest >> test12RepeatCardCanRespondToAssertionMessage [

	| aTestCard |
	aTestCard := RepeatCard new.
	self assert: aTestCard assertThatIsACard
]

{ #category : #tests }
CardsTest >> test13RepeatCardEqualsAnotherInstanceOfSameCard [

	| aTestCard aCard |
	aTestCard := RepeatCard new.
	aCard := RepeatCard new.
	self assert: aTestCard equals: aCard
]

{ #category : #tests }
CardsTest >> test14RedoCardEqualsAnotherInstanceOfSameCard [

	| aTestCard aCard |
	aTestCard := RedoCard new.
	aCard := RedoCard new.
	self assert: aTestCard equals: aCard
]

{ #category : #tests }
CardsTest >> test15RedoCardCanRespondToAssertionMessage [

	| aTestCard |
	aTestCard := RedoCard new.
	self assert: aTestCard assertThatIsACard
]
