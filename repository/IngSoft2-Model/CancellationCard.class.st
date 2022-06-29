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

	^ true
]
