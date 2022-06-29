Class {
	#name : #DistanceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DistanceTest >> should: errorBlock raise: errorClass withMessage: expectedErrorMessage [

	| errorWasRaised errorMessage |
	errorBlock
		on: errorClass
		do: [ :error | 
			errorWasRaised := true.
			errorMessage := error messageText ]
]

{ #category : #tests }
DistanceTest >> test01ParsecCanBeCreated [

	| aParsec |
	aParsec := Parsec distanceOf: 3.
	self assert: aParsec isValid
]

{ #category : #tests }
DistanceTest >> test02ParsecCannotBeANegativeValue [

	| aParsec error errorMessage |
	aParsec := [ Parsec distanceOf: -5 ].
	error := Error.
	errorMessage := 'Parsecs value has to be greater or equal than zero'.
	self should: aParsec raise: error withMessage: errorMessage
]

{ #category : #tests }
DistanceTest >> test03LightYearCanBeCreated [

	| aLightYear |
	aLightYear  := Lightyear  distanceOf: 3.
	self assert: aLightYear  isValid
]

{ #category : #tests }
DistanceTest >> test04LightYearCannotBeANegativeValue [

	| aLightyear error errorMessage |
	aLightyear  := [ Lightyear  distanceOf: -5 ].
	error := Error.
	errorMessage := 'LightYears value has to be greater or equal than zero'.
	self should: aLightyear  raise: error withMessage: errorMessage
]

{ #category : #tests }
DistanceTest >> test05AParsecEquals3LightYears [

	| aParsec aLightYear |
	aParsec:= Parsec distanceOf: 1.
	aLightYear:= Lightyear distanceOf: 3.
	
	self assert: aParsec amountInLightYears equals: aLightYear amount.
]

{ #category : #tests }
DistanceTest >> test06SixLightYearsEqualTwoParsecs [

	| aDistanceInParsecs aDistanceInLightYears |
	aDistanceInParsecs := Parsec distanceOf: 2.
	aDistanceInLightYears := Lightyear distanceOf: 6.
	
	self assert: aDistanceInParsecs amount equals: aDistanceInLightYears amountInParsecs.
]
