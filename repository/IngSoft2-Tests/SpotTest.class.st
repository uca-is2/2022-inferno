Class {
	#name : #SpotTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpotTest >> test01SpotCanBeCreatedAndLoadedWithAnEffect [

	| aSpot aSpeedUp |
	aSpeedUp := SpeedUp new.
	aSpot := Spot createWith: aSpeedUp.
	self assert: (aSpot effectAtSpot isKindOf: SpeedUp)
]

{ #category : #tests }
SpotTest >> test02SpotCanBeCreatedAndLoadedWithAMoonwalkWithAValue [

	| aSpot aMoonwalk |
	aMoonwalk := Moonwalk createWith: 4.
	aSpot := Spot createWith: aMoonwalk.
	self assert: (aSpot effectAtSpot isKindOf: Moonwalk)
]

{ #category : #tests }
SpotTest >> test03SpotCanBeCreatedAndLoadedWithHyperJumpsArrayInParsecs [

	| aSpot arrayOfJumps |
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { 2. 4. 6 }.
	aSpot := Spot createWith:
		         (Hyperjump createWith: arrayOfJumps measuredIn: 'parsecs').
	self assert: aSpot effectAtSpot jumpValues equals: arrayOfJumps
]

{ #category : #tests }
SpotTest >> test04SpotCanBeCreatedAndLoadedWithHyperJumpsArrayInLightyears [

	| aSpot arrayOfJumps expectedArrayOfJumps |
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { 3. 6. 9 }.
	aSpot := Spot createWith:
		         (Hyperjump
			          createWith: arrayOfJumps
			          measuredIn: 'lightyears').
	expectedArrayOfJumps := OrderedCollection new: 3.
	expectedArrayOfJumps addAllFirst: { 3. 2. 1 }.
	self
		assert: aSpot effectAtSpot jumpValues
		equals: expectedArrayOfJumps
]
