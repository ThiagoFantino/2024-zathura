Class {
	#name : #TurnHandler,
	#superclass : #Object,
	#instVars : [
		'spaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
TurnHandler class >> assertValidNumberOf: someSpaceShips [

	someSpaceShips isEmpty ifTrue: [
		Error signal: 'Game must have at least one spaceship' ]
]

{ #category : #'instance creation' }
TurnHandler class >> with: someSpaceShips [

	self assertValidNumberOf: someSpaceShips.
	^ self new initializeWith: someSpaceShips
]

{ #category : #playing }
TurnHandler >> changeTurns [

	spaceships add: spaceships first.
	spaceships removeFirst
]

{ #category : #playing }
TurnHandler >> checkNitroTurns: spaceshipTurn [

	spaceshipTurn nitroTurns > 0 ifTrue: [
		spaceshipTurn assignNitroTurns: -1 ]
]

{ #category : #initialization }
TurnHandler >> initializeWith: someSpaceShips [

	spaceships := someSpaceShips asOrderedCollection
]

{ #category : #playing }
TurnHandler >> nextSpaceshipTurn [

	| spaceshipTurn |
	spaceshipTurn := self nextTurn.
	self checkNitroTurns: spaceshipTurn.
	[ spaceshipTurn turnsToLose > 0 ] whileTrue: [
		spaceshipTurn losesTurns: -1.
		self changeTurns.
		spaceshipTurn := self nextTurn ].
	self changeTurns.
	^ spaceshipTurn
]

{ #category : #playing }
TurnHandler >> nextTurn [

	| spaceshipTurn |
	spaceshipTurn := spaceships first.
	^ spaceshipTurn
]

{ #category : #accessing }
TurnHandler >> spaceships [

	^ spaceships
]
