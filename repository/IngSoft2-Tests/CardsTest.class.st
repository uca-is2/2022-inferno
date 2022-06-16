Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsTest >> test01SpeedCardCanRespondToAssertionIfItIsATypeOfCard [
	| aTestCard |
	aTestCard := SpeedCard new.
	self assert: aTestCard assertThatIsACard.
]

{ #category : #tests }
CardsTest >> test02OverloadCardCanRespondToAssertionIfItIsATypeOfCard [
	| aTestCard |
	aTestCard := OverloadCard  new.
	self assert: aTestCard assertThatIsACard.
]

{ #category : #tests }
CardsTest >> test03AccelerationCardCanRespondToAssertionIfItIsATypeOfCard [
	| aTestCard |
	aTestCard := AccelerationCard  new.
	self assert: aTestCard assertThatIsACard.
]

{ #category : #tests }
CardsTest >> test04CancellationCardCanRespondToAssertionIfItIsATypeOfCard [
	| aTestCard |
	aTestCard := CancellationCard new.
	self assert: aTestCard assertThatIsACard.
]

{ #category : #tests }
CardsTest >> test05RedoCardCanRespondToAssertionIfItIsATypeOfCard [
	| aTestCard |
	aTestCard := RedoCard new.
	self assert: aTestCard assertThatIsACard.
]

{ #category : #tests }
CardsTest >> test06RepeatCardCanRespondToAssertionIfItIsATypeOfCard [
	| aTestCard |
	aTestCard := RepeatCard new.
	self assert: aTestCard assertThatIsACard.
]
