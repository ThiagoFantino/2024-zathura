Class {
	#name : #SpaceShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceShipTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCanBeCreatedWithAName [

	| aSpaceShip |
	aSpaceShip := SpaceShip called: 'Danny' withMaxFuel: 10.
	self assert: aSpaceShip name equals: 'Danny'
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCanBeCreatedWithFuel [

	| aSpaceShip |
	aSpaceShip := SpaceShip called: 'Danny' withMaxFuel: 10.
	self assert: aSpaceShip fuelTank currentFuel equals: 10
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCanMoveBackwards [

	| aSpaceShip pos1 pos2 |
	aSpaceShip := SpaceShip called: 'Danny' withMaxFuel: 10.
	pos1 := SpaceShipPosition createAt: 5 and: 1.
	pos2 := SpaceShipPosition createAt: 4 and: 1.
	aSpaceShip moveTo: pos1 needing: 5.
	aSpaceShip moveTo: pos2 needing: 1.

	self assert: aSpaceShip tileNumber equals: 4
]

{ #category : #running }
SpaceShipTest >> testASpaceshipCannotBeCreatedWithoutAName [

	| aName |
	aName := ''.
	self
		should: [ SpaceShip called: aName withMaxFuel: 10 ]
		raise: Error
		withMessage: 'Ship cant be created without a name'
]

{ #category : #running }
SpaceShipTest >> testASpaceshipIsMovedOnePosition [

	| aSpaceShip pos |
	aSpaceShip := SpaceShip called: 'Danny' withMaxFuel: 10.
	pos := SpaceShipPosition createAt: 2 and: 1.
	aSpaceShip moveTo: pos needing: 1.
	self assert: aSpaceShip tileNumber equals: 2
]

{ #category : #running }
SpaceShipTest >> testLostTurnsCanBeStacked [

	| aSpaceShip |
	aSpaceShip := SpaceShip called: 'Danny' withMaxFuel: 10.
	self assert: aSpaceShip turnsToLose equals: 0.
	aSpaceShip losesTurns: 2.
	self assert: aSpaceShip turnsToLose equals: 2.
	aSpaceShip losesTurns: 3.
	self assert: aSpaceShip turnsToLose equals: 5
]
