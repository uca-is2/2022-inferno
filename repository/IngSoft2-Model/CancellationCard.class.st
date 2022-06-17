"
i represent a type of card: cancellation

"
Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CancellationCard >> = aCard [

	^ self class = aCard class
]

{ #category : #assertions }
CancellationCard >> assertThatIsACard [

	^ self checkIfItIsAValidCard
]

{ #category : #assertions }
CancellationCard >> checkIfItIsAValidCard [

	^ (self isKindOf: SpeedCard) or: ((self isKindOf: OverloadCard) or:
			   ((self isKindOf: AccelerationCard) or:
				    ((self isKindOf: CancellationCard) or:
					     ((self isKindOf: RedoCard) or: (self isKindOf: RepeatCard)))))
]
