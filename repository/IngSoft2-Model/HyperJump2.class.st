Class {
	#name : #HyperJump2,
	#superclass : #Object,
	#instVars : [
		'jumpsArray'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
HyperJump2 class >> assertValid: aJumpsArray [ 
	aJumpsArray do: [ :distance | (distance amount) >= 0 ifFalse: [ 
			Error signal: 'Values of the collection cannot be a negative number' ] ].
]

{ #category : #'class initialization' }
HyperJump2 class >> createWith: aJumpsArray [

	self assertValid: aJumpsArray.
	^self new initializeWith: aJumpsArray.
	
]

{ #category : #initialization }
HyperJump2 >> initializeWith: aJumpsArray [

	jumpsArray:= aJumpsArray sorted reverse.
]
