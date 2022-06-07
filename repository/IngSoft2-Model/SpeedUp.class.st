"
i represent a type of effect: speedup
"
Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
SpeedUp >> applyTo: aGamePositions limitedBy: length [
	| lapBeforeEffect positionBeforeEffect |
	lapBeforeEffect := aGamePositions currentSpaceshipLap.
	positionBeforeEffect := aGamePositions currentSpaceshipPosition.
	(positionBeforeEffect + 4 >= length)ifTrue: [ 
			(lapBeforeEffect + 1 >= aGamePositions laps)ifTrue: [ 
				aGamePositions moveCurrentTo: length andLap: aGamePositions laps.]
				ifFalse: [ 
					aGamePositions moveCurrentTo: positionBeforeEffect + 4 - length
						andLap: lapBeforeEffect + 1 ] ]
		ifFalse: [ aGamePositions moveCurrentTo: positionBeforeEffect + 4 ]
]
