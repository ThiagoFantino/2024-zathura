Class {
	#name : #HyperJump,
	#superclass : #Effect,
	#instVars : [
		'distances'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJump class >> of: distances [

	^ self new initializeOf: distances
]

{ #category : #'instance creation' }
HyperJump >> initializeOf: groupOfDistances [

	distances := groupOfDistances asOrderedCollection
]

{ #category : #playing }
HyperJump >> nextJumpValue [

	| valueAsParsec |
	valueAsParsec := (distances at: 1) valueAsParsecs.
	distances add: distances first.
	distances removeFirst.
	^ valueAsParsec
]

{ #category : #playing }
HyperJump >> triggeredBy: aSpaceship on: anEffectManager [

	| valueAsParsec |
	valueAsParsec := self nextJumpValue.

	anEffectManager move: aSpaceship jumping: valueAsParsec
]
