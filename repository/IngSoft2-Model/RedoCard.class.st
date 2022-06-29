"
I represent a type of card: redo
"
Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
RedoCard >> = aCard [

	^ self class = aCard class
]

{ #category : #assertions }
RedoCard >> assertThatIsACard [

	^ self checkIfItIsAValidCard
]

{ #category : #assertions }
RedoCard >> checkIfItIsAValidCard [

	^ true
]
