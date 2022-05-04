Class {
	#name : #DiceCupTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceCupTest >> testDiceCupIsACollectionOfDice [
	| aDie1 aDie2 aDiceCup |
	aDie1:= Die with:5.
	aDie2:= LoadedDie with:6 loadedWith: 6.
	aDiceCup:= DiceCup with: [ aDie1 , aDie2 ].

]

{ #category : #tests }
DiceCupTest >> testDiceCupRollIsAnInteger [
	| aDie1 aDie2 aDiceCup aResult aCollection|
	aDie1:= Die with:5.
	aDie2:= LoadedDie with:6 loadedWith: 6.
	aCollection:= Array new: 2. 
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aDiceCup:= DiceCup with: aCollection.
	aResult:= aDiceCup roll.
	self assert: aResult isInteger.
]

{ #category : #tests }
DiceCupTest >> testDiceCupWithLoadedRollIsSumOfLoadedSides [
	| aDie1 aDie2 aDiceCup aResult aCollection|
	aDie1:= LoadedDie with:5 loadedWith:4.
	aDie2:= LoadedDie with:6 loadedWith: 6.
	aCollection:= Array new: 2. 
	aCollection at: 1 put: aDie1.
	aCollection at: 2 put: aDie2.
	aDiceCup:= DiceCup with: aCollection.
	aResult:= aDiceCup roll.
	self assert: aResult equals:10.
]
