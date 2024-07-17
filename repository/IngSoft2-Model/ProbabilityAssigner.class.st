Class {
	#name : #ProbabilityAssigner,
	#superclass : #Object,
	#instVars : [
		'element',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
ProbabilityAssigner class >> assertIsBetweenZeroAndOne: probability [

	(probability between: 0 and: 1) ifFalse: [
		Error signal: 'Probability must be between 0 and 1!' ]
]

{ #category : #'instance creation' }
ProbabilityAssigner class >> with: element and: probability [

	self assertIsBetweenZeroAndOne: probability.

	^ self new initializeWith: element and: probability
]

{ #category : #accessing }
ProbabilityAssigner >> element [

	^ element
]

{ #category : #initialization }
ProbabilityAssigner >> initializeWith: anElement and: aProbability [

	element := anElement.
	probability := aProbability
]

{ #category : #accessing }
ProbabilityAssigner >> probability [

	^ probability
]
