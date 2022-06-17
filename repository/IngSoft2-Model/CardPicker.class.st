"
i reprsent a type of effect: cardpicker

"
Class {
	#name : #CardPicker,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CardPicker >> applyTo: aBoard by: aSpaceship [
	
	| aDealer pickedCard |
	aDealer := Dealer new.
	pickedCard := aDealer dealOne.
	^ pickedCard .
]
