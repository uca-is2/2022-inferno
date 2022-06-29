"
I represent a Dealer

"
Class {
	#name : #Dealer,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #dealing }
Dealer >> dealInitialCards [

	| randomcard1 randomcard2 initialCards initialHand |
	randomcard1 := self dealOne.
	randomcard2 := self dealOne.
	initialCards := { 
		                randomcard1.
		                randomcard2 }.
	initialHand := Hand containing: initialCards.
	^ initialHand
]

{ #category : #dealing }
Dealer >> dealOne [

	| array randomcard |
	array := { 
		         SpeedCard new.
		         OverloadCard new.
		         RedoCard new.
		         AccelerationCard new.
		         CancellationCard new.
		         RepeatCard new }.
	randomcard := array atRandom.
	^ randomcard
]
