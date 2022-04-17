Class {
	#name : #DiceCupTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'tests-DiceCup' }
DiceCupTests >> testDiceCupRollResultIsTheSumOfLoadedDiceSumResult [

	| die1 die2 die3 die4 aDiceCup rollResult |
	die1 := LoadedDie with: 4.
	die2 := LoadedDie with: 6.
	die3 := LoadedDie with: 9.
	die4 := LoadedDie with: 1.

	aDiceCup := DiceCup witAll: { 
			        die1.
			        die2.
			        die3.
					  die4. }.
	rollResult := aDiceCup roll.
	self assert: rollResult equals: 20.

]

{ #category : #'tests-DiceCup' }
DiceCupTests >> testDiceCupRollWithRandomIsAnInteger [
|aDiceCup rollResult|
aDiceCup := DiceCup witAll: #(4 5 6).
rollResult := aDiceCup roll.
self assert: rollResult isInteger
]
