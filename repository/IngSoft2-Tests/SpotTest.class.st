Class {
	#name : #SpotTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpotTest >> test01SpotCanBeCreatedAndHasNoEffectAsDefault [

	| aSpot |
	aSpot := Spot create.
	self assert: (aSpot effectAtSpot isKindOf: NoEffect).
]

{ #category : #tests }
SpotTest >> test02SpotCanBeLoadedWithANotNullEffect [

	| aSpot aSpeedUp|
	aSpeedUp := SpeedUp new.
	aSpot := Spot create.
	aSpot loadEffect: aSpeedUp.
	self assert: (aSpot effectAtSpot isKindOf: SpeedUp).
]
