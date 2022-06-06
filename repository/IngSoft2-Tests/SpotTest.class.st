Class {
	#name : #SpotTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpotTest >> test01SpotCanBeCreatedAndLoadedWithAnEffect [

	| aSpot aSpeedUp|
	aSpeedUp := SpeedUp new.
	aSpot := Spot createWith: aSpeedUp.
	self assert: (aSpot effectAtSpot isKindOf: SpeedUp).
]
