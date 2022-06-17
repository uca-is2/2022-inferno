Class {
	#name : #Dealer,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #dealing }
Dealer >> dealInitialCards [
	| array  randomcard1 randomcard2 initialHand |
	array := { SpeedCard new. OverloadCard new. RedoCard new. AccelerationCard new. CancellationCard new. RepeatCard new.}.
	randomcard1 := array atRandom.
	randomcard2 := array atRandom.
	initialHand := { randomcard1 . randomcard2  }.
	^ initialHand

]
