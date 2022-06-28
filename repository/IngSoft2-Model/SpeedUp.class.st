"
i represent a type of effect: speedup
"
Class {
	#name : #SpeedUp,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
SpeedUp >> applyTo: aBoard by: aSpaceship [

	| positionBeforeSpeedUp  speedUpNumber |
	positionBeforeSpeedUp := aBoard positionOf: aSpaceship.
	speedUpNumber := 4.
	aBoard
		move: aSpaceship
		withoutTriggeringNewEffectsfrom: positionBeforeSpeedUp
		to: speedUpNumber
]
