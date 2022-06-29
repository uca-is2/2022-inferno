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

	^ self class = aCard class
]

{ #category : #assertions }
AccelerationCard >> assertThatIsACard [

	^ self checkIfItIsAValidCard
]

{ #category : #assertions }
AccelerationCard >> checkIfItIsAValidCard [

	^ true
]

{ #category : #assertions }
AccelerationCard >> effectOnRoll [

	^ 1
]
