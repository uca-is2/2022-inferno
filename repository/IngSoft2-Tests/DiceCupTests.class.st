Class {
	#name : #DiceCupTests,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'tests-DiceCup' }
DiceCupTests >> testDiceCupRollResultIsTheSumOfLoadedDiceSumResult [

	| aDiceCup rollResult |

	aDiceCup := DiceCup witAllLoaded: #(6 4 3 7). 
	rollResult := aDiceCup roll.
	self assert: rollResult equals: 20.

]

{ #category : #'tests-DiceCup' }
DiceCupTests >> testDiceCupRollWithRandomIsAnInteger [

	| aDiceCup rollResult |
	aDiceCup := DiceCup witAll: #( 4 5 6 ).
	rollResult := aDiceCup roll.
	self assert: rollResult isInteger
]
