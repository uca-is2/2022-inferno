Class {
	#name : #ZathuraTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ZathuraTest >> test01AGameOfZathuraInfernoCanBePlayedByTurnsTilFinished [

	| aCollectionOfSpaceships aBoard aCollectionOfSpots anEffectFiller aCollectionOfMoonwalkNumbers aCollectionOfJumpArrays lengthInParsecs aDiceCup aCollectionOfDice zathura aDie1 aDie2 |
	anEffectFiller := EffectFiller new.
	aCollectionOfMoonwalkNumbers:= {5. 3. 2. 1. 2 }.
	aCollectionOfJumpArrays:= { #(1 2 3 ). #(0 3 5). #(2 4 6). #(3 4 5)}.
	aCollectionOfSpots :=  anEffectFiller fillWithEffects: 50 with: aCollectionOfJumpArrays and: aCollectionOfMoonwalkNumbers .
	aCollectionOfSpaceships := { 'Razor Crest'. 'Millenium Falcon'. 'SC30 StarFighter' }.
	lengthInParsecs := 100.
	aBoard := Board with: aCollectionOfSpots withALengthOf: lengthInParsecs around: 3 playedBy: aCollectionOfSpaceships.
	aDie1:= LoadedDie with:5 loadedWith:4.
	aDie2:= LoadedDie with:6 loadedWith: 6.
	aCollectionOfDice := { aDie1. aDie2. }.
	aDiceCup := DiceCup with: aCollectionOfDice.
	zathura := Zathura playWith: aDiceCup over: aBoard.
	[ zathura hasGameFinished ] whileFalse: [ zathura playNextTurn ].
	self assert: zathura hasGameFinished.
]
