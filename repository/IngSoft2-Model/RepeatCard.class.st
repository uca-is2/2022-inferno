"
i represent a type of card: repeat
"
Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
RepeatCard >> = aCard [

	^ self class = aCard class
]

{ #category : #assertion }
RepeatCard >> assertThatIsACard [

	^ self checkIfItIsAValidCard
]

{ #category : #assertions }
RepeatCard >> checkIfItIsAValidCard [

	^ true
]
