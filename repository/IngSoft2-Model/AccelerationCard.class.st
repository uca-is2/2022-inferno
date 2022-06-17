"
i represent a type of card: acceleration
"
Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
AccelerationCard >> = aCard [
	^(self class = (aCard class))
]

{ #category : #assertions }
AccelerationCard >> assertThatIsACard [
	^ self checkIfItIsAValidCard.
]

{ #category : #assertions }
AccelerationCard >> checkIfItIsAValidCard [
	^ (self isKindOf: SpeedCard )or: ((self isKindOf: OverloadCard  )or: ((self isKindOf: AccelerationCard )or:((self isKindOf: CancellationCard )or:((self isKindOf: RedoCard )or:(self isKindOf: RepeatCard ))))).
]

{ #category : #playing }
AccelerationCard >> effectOnRoll [
	^1.
]
