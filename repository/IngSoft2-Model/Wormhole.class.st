"
i represent a type of effect: wormhole
"
Class {
	#name : #Wormhole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
Wormhole >> applyTo: aGamePositions limitedBy: length [ 
	| lapBeforeEffect positionBeforeEffect |
	lapBeforeEffect := aGamePositions currentSpaceshipLap.
	positionBeforeEffect := aGamePositions currentSpaceshipPosition.
	(lapBeforeEffect = 0)ifTrue: [ 
			positionBeforeEffect - 4 < 1
				ifTrue: [ aGamePositions moveCurrentTo: 1 ]
				ifFalse: [ aGamePositions moveCurrentTo: positionBeforeEffect - 4 ] ]
		ifFalse: [ 
			positionBeforeEffect - 4 < 1 ifTrue: [ 
				aGamePositions moveCurrentTo:  positionBeforeEffect + length - 4
					andLap: lapBeforeEffect - 1 ] ]
]
