Class {
	#name : #DiceCupTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceCupTest >> test01DiceCupRollIsAnInteger [

	| aDie1 aDie2 aDiceCup aResult aCollection aDie3 |
	aDie1 := Die with: 5.
	aDie2 := Die with: 6.
	aDie3 := Die with: 6.
	aCollection := Array new: 3.
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aCollection at: 3 put: aDie3.
	aDiceCup := DiceCup with: aCollection.
	aResult := aDiceCup roll.
	self assert: aResult isInteger
]

{ #category : #tests }
DiceCupTest >> test02DiceCupWithLoadedRollIsSumOfLoadedSides [

	| aDie1 aDie2 aDiceCup aResult aCollection |
	aDie1 := LoadedDie with:  4.
	aDie2 := LoadedDie with:  6.
	aCollection := Array new: 2.
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aDiceCup := DiceCup with: aCollection.
	aResult := aDiceCup roll.
	self assert: aResult equals: 10
]
