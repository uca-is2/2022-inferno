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
	arrayOfJumps addAllFirst: { Parsec distanceOf: 2. Parsec distanceOf: 4. Parsec distanceOf:6 }.
	aSpot := Spot createWith:
		         (Hyperjump createWith: arrayOfJumps).
	arrayOfJumps := ((arrayOfJumps sorted) reversed).
	self assert: aSpot effectAtSpot jumpValues equals: arrayOfJumps
]

{ #category : #tests }
SpotTest >> test04SpotCanBeCreatedAndLoadedWithHyperJumpsArrayInLightyears [

	| aSpot arrayOfJumps expectedArrayOfJumps |
	arrayOfJumps := OrderedCollection new: 3.
	arrayOfJumps addAllFirst: { Lightyear distanceOf: 3. Lightyear distanceOf: 6. Lightyear distanceOf: 9 }.
	aSpot := Spot createWith:
		         (Hyperjump
			          createWith: arrayOfJumps).
	expectedArrayOfJumps := (arrayOfJumps sorted)reversed.
	self
		assert: aSpot effectAtSpot jumpValues equals: expectedArrayOfJumps
]
