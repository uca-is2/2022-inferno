"
i represent a type of effect: wormhole
"
Class {
	#name : #Wormhole,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
Wormhole >> applyTo: aBoard by: aSpaceship [

	| positionBeforeWormhole  wormholeNumber |
	wormholeNumber := -4.
	positionBeforeWormhole := aBoard positionOf: aSpaceship.
	aBoard move: aSpaceship back: wormholeNumber from: positionBeforeWormhole.
]
