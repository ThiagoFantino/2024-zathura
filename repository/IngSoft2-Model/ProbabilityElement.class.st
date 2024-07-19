Class {
	#name : #ProbabilityElement,
	#superclass : #Object,
	#instVars : [
		'element',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ProbabilityElement class >> assertIsBetweenZeroAndOne: probability [

	(probability between: 0 and: 1) ifFalse: [
		Error signal: 'Probability must be between 0 and 1!' ]
]

{ #category : #'instance creation' }
ProbabilityElement class >> with: element and: probability [

	self assertIsBetweenZeroAndOne: probability.

	^ self new initializeWith: element and: probability
]

{ #category : #accessing }
ProbabilityElement >> element [

	^ element
]

{ #category : #initialization }
ProbabilityElement >> initializeWith: anElement and: aProbability [

	element := anElement.
	probability := aProbability
]

{ #category : #accessing }
ProbabilityElement >> probability [

	^ probability
]
