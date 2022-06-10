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
	| positionBeforeSpeedUp lapBeforeSpeedUp spotBeforeSpeedUp speedUpNumber |
	positionBeforeSpeedUp := aBoard positionOf: aSpaceship.
	lapBeforeSpeedUp := positionBeforeSpeedUp lapNumber .
	spotBeforeSpeedUp := positionBeforeSpeedUp spotNumber.
	speedUpNumber := 4.
	aBoard move: aSpaceship fromSpot: spotBeforeSpeedUp andLap: lapBeforeSpeedUp to: speedUpNumber.
	^ (aBoard spaceshipPositions).
]
