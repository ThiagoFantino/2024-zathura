Class {
	#name : #Distribution,
	#superclass : #Object,
	#instVars : [
		'distributionCollection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Distribution class >> assertSumOfProbabilitiesEqualsToOne: probabilityTileList [

	(probabilityTileList
		 inject: 0
		 into: [ :initial :probabilityTile |
		 initial + probabilityTile probability ]) = 1 ifFalse: [
		Error signal: 'The sum of the probabilities must be equal to 1!' ]

	
]

{ #category : #'instance creation' }
Distribution class >> with: probabilityElementList [

	self assertSumOfProbabilitiesEqualsToOne: probabilityElementList.

	^ self new initializeWith: probabilityElementList
]

{ #category : #initialization }
Distribution >> checkProbabilityOf: anElement [

	^ distributionCollection occurrencesOf: anElement
]

{ #category : #initialization }
Distribution >> initializeWith: probabilityElementList [

	distributionCollection := OrderedCollection new.

	probabilityElementList do: [ :probabilityElement |
		(probabilityElement probability * 100) asInteger timesRepeat: [
			distributionCollection add: probabilityElement element ] ]
]

{ #category : #creating }
Distribution >> randomCollectionWith: length [

	| randomCollection |
	randomCollection := OrderedCollection new.

	length timesRepeat: [ randomCollection add: self randomElement ].

	^ randomCollection
]

{ #category : #accessing }
Distribution >> randomElement [

	^ distributionCollection atRandom
]
