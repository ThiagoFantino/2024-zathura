Class {
	#name : #TurnHandlerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
TurnHandlerTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
TurnHandlerTest >> testATurnHandlerCanBeCreatedWithSomeSpaceships [

	| aTurnHandler aSpaceShip |
	aSpaceShip := SpaceShip called: 'Danny' withMaxFuel: 10.
	aTurnHandler := TurnHandler with: { aSpaceShip }.
	self assert: aTurnHandler spaceships first name equals: 'Danny'
]

{ #category : #tests }
TurnHandlerTest >> testATurnHandlerCannotBeCreatedWithoutSpaceships [

	self
		should: [ TurnHandler with: {  } ]
		raise: Error
		withMessage: 'Game must have at least one spaceship'
]

{ #category : #tests }
TurnHandlerTest >> testSpaceship1ThrowsFirst [

	| aTurnHandler aSpaceShip1 aSpaceShip2 |
	aSpaceShip1 := SpaceShip called: 'Danny' withMaxFuel: 10.
	aSpaceShip2 := SpaceShip called: 'Walter' withMaxFuel: 10.
	aTurnHandler := TurnHandler with: {
			                aSpaceShip1.
			                aSpaceShip2 }.
	self assert: aTurnHandler nextSpaceshipTurn name equals: 'Danny'
]

{ #category : #tests }
TurnHandlerTest >> testSpaceship2ThrowsAfterSpaceship1 [

	| aTurnHandler aSpaceShip1 aSpaceShip2 |
	aSpaceShip1 := SpaceShip called: 'Danny' withMaxFuel: 10.
	aSpaceShip2 := SpaceShip called: 'Walter' withMaxFuel: 10.
	aTurnHandler := TurnHandler with: {
			                aSpaceShip1.
			                aSpaceShip2 }.
	aTurnHandler nextSpaceshipTurn.
	self assert: aTurnHandler nextSpaceshipTurn name equals: 'Walter'
]
