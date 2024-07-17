Class {
	#name : #SpaceShip,
	#superclass : #Object,
	#instVars : [
		'name',
		'tileNumber',
		'lap',
		'turnsToLose',
		'needsToThrow',
		'ally',
		'fuelTank',
		'leak',
		'nitroTurns'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
SpaceShip class >> assertValidNameFor: aName [

	aName isEmpty ifTrue: [
		Error signal: 'Ship cant be created without a name' ]
]

{ #category : #'instance creation' }
SpaceShip class >> called: aName withMaxFuel: anAmount [

	self assertValidNameFor: aName.
	^ self new initialize: aName withMaxFuel: anAmount
]

{ #category : #activation }
SpaceShip >> activateLeakCardPenalty [

	leak := true
]

{ #category : #accessing }
SpaceShip >> ally [

	^ ally
]

{ #category : #playing }
SpaceShip >> applyPenaltyForEmptyFuelTank [

	tileNumber := 1.
	fuelTank refuelToMax.
	self losesTurns: 2.
	leak := false
]

{ #category : #playing }
SpaceShip >> assignNitroTurns: amountOfTurns [

	nitroTurns := nitroTurns + amountOfTurns
]

{ #category : #playing }
SpaceShip >> changeRollingResultNeededToMove: aNumber [

	needsToThrow := aNumber
]

{ #category : #playing }
SpaceShip >> checkLeakPenaltyToDecreaseFuel: aFuelAmount [

	leak
		ifTrue: [ self decreaseFuelBy: aFuelAmount * 2 ]
		ifFalse: [ self decreaseFuelBy: aFuelAmount ]
]

{ #category : #playing }
SpaceShip >> decreaseFuelBy: amountOfFuel [

	fuelTank decreaseFuelBy: amountOfFuel
]

{ #category : #accessing }
SpaceShip >> fuelTank [

	^ fuelTank
]

{ #category : #playing }
SpaceShip >> handleAllyFuelForMovePositionBy: aNumber lapBy: quantityOfLapsToMove [

	ally fuelTank currentFuel < fuelTank currentFuel abs
		ifTrue: [
			ally applyPenaltyForEmptyFuelTank.
			self applyPenaltyForEmptyFuelTank ]
		ifFalse: [
			ally decreaseFuelBy: fuelTank currentFuel abs.
			fuelTank fuel: 0.
			self moveToNextPositionBy: aNumber lapBy: quantityOfLapsToMove ]
]

{ #category : #playing }
SpaceShip >> handleEmptyFuelTankForMovePositionBy: aNumber lapBy: quantityOfLapsToMove [

	ally ifNil: [ self applyPenaltyForEmptyFuelTank ] ifNotNil: [
		self
			handleAllyFuelForMovePositionBy: aNumber
			lapBy: quantityOfLapsToMove ]
]

{ #category : #initialization }
SpaceShip >> initialize: aName withMaxFuel: anAmount [

	name := aName.
	tileNumber := 1.
	lap := 1.
	turnsToLose := 0.
	nitroTurns := 0.
	needsToThrow := 0.
	fuelTank := FuelTank withMaxFuel: anAmount.
	ally := nil.
	leak := false
]

{ #category : #asserting }
SpaceShip >> isAlliedWith: anotherSpaceship [

	ally := anotherSpaceship
]

{ #category : #'accessing - arguments' }
SpaceShip >> lap [

	^ lap
]

{ #category : #playing }
SpaceShip >> losesTurns: amountOfTurns [

	turnsToLose := turnsToLose + amountOfTurns
]

{ #category : #playing }
SpaceShip >> movePositionBy: aNumber lapBy: quantityOfLapsToMove neededFuel: aFuelAmount [

	needsToThrow = 0 ifFalse: [ ^ self ].
	self checkLeakPenaltyToDecreaseFuel: aFuelAmount.

	fuelTank isEmpty
		ifTrue: [
			self
				handleEmptyFuelTankForMovePositionBy: aNumber
				lapBy: quantityOfLapsToMove ]
		ifFalse: [
		self moveToNextPositionBy: aNumber lapBy: quantityOfLapsToMove ]
]

{ #category : #playing }
SpaceShip >> moveToNextPositionBy: aNumber lapBy: quantityOfLapsToMove [

	tileNumber := tileNumber + aNumber.
	lap := lap + quantityOfLapsToMove
]

{ #category : #accessing }
SpaceShip >> name [

	^ name
]

{ #category : #initialization }
SpaceShip >> nitroTurns [

	^ nitroTurns
]

{ #category : #playing }
SpaceShip >> rollDiceUsing: aDiceRoller [

	| rolledNumber |
	rolledNumber := aDiceRoller roll.
	(needsToThrow = 0 or: [ rolledNumber = needsToThrow ]) ifTrue: [
		needsToThrow := 0 ].
	^ rolledNumber
]

{ #category : #asserting }
SpaceShip >> setAllyToNil [

	ally := nil
]

{ #category : #asserting }
SpaceShip >> setLeakToFalse [

	leak := false
]

{ #category : #playing }
SpaceShip >> skipTurn [

	self losesTurns: 1.
	fuelTank refuelToMax
]

{ #category : #'accessing - arguments' }
SpaceShip >> tileNumber [

	^ tileNumber
]

{ #category : #accessing }
SpaceShip >> turnsToLose [

	^ turnsToLose
]
