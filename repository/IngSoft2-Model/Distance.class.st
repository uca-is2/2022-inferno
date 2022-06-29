Class {
	#name : #Distance,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Distance >> <= aDistance [
	
	^ self amountInParsecs <= aDistance amountInParsecs .
]

{ #category : #actions }
Distance >> amount [

	^ self subclassResponsibility
]

{ #category : #actions }
Distance >> amountInLightYears [

	^ self subclassResponsibility
]

{ #category : #actions }
Distance >> amountInParsecs [

	^ self subclassResponsibility
]
