"
i represent a type of card: overload
"
Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
OverloadCard >> = aCard [

	^ self class = aCard class
]

{ #category : #assertions }
OverloadCard >> assertThatIsACard [

	^ self checkIfItIsAValidCard
]

{ #category : #assertions }
OverloadCard >> checkIfItIsAValidCard [

	^ (self isKindOf: SpeedCard) or: ((self isKindOf: OverloadCard) or:
			   ((self isKindOf: AccelerationCard) or:
				    ((self isKindOf: CancellationCard) or:
					     ((self isKindOf: RedoCard) or: (self isKindOf: RepeatCard)))))
]

{ #category : #effect }
OverloadCard >> effectOnRoll [

	^ -2
]
