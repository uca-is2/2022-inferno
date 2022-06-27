"
i represent a type of effect: atomicbomb
"
Class {
	#name : #AtomicBomb,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
AtomicBomb >> applyTo: aBoard by: aSpaceship [
	aBoard moveAllSpaceshipsToStartOfLap.
]
