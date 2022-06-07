"
i represent the abstract class effect
"
Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Effect class >> isAbstract [
		
	^ self == Effect
]
