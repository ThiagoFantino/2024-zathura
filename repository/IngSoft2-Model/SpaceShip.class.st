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
		'nitroTurns',
		'position'
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
SpaceShip >> >= anotherSpaceship [

	^ self lap > anotherSpaceship lap or:
		  (self lap = anotherSpaceship lap and:
			   self tileNumber > anotherSpaceship tileNumber)
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

	self resetPosition.
	fuelTank refuelToMax.
	self losesTurns: 2.
	leak := false
]

{ #category : #playing }
SpaceShip >> assignNitroTurns: amountOfTurns [

	nitroTurns := nitroTurns + amountOfTurns
]

{ #category : #playing }
SpaceShip >> canPlay [

	turnsToLose <= 0 ifTrue: [ ^ true ].
	^ false
]

{ #category : #playing }
SpaceShip >> canProvideToAnAlly: anAmountOfFuel [

	fuelTank currentFuel > anAmountOfFuel ifTrue: [ ^ true ].
	^ false
]

{ #category : #playing }
SpaceShip >> changeRollingResultNeededToMove: aNumber [

	needsToThrow := aNumber
]

{ #category : #playing }
SpaceShip >> checkForRollInHyperGravity: rolledNumber [

	(needsToThrow = 0 or: [ rolledNumber = needsToThrow ]) ifTrue: [
		needsToThrow := 0 ]
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
SpaceShip >> handleAllyFuelToMoveFor: positionAfterMovement [

	(ally canProvideToAnAlly: fuelTank currentFuel abs)
		ifTrue: [
			ally decreaseFuelBy: fuelTank currentFuel abs.
			fuelTank fuel: 0.
			self moveToNextPostion: positionAfterMovement ]
		ifFalse: [
			ally applyPenaltyForEmptyFuelTank.
			self applyPenaltyForEmptyFuelTank ]
]

{ #category : #playing }
SpaceShip >> handleEmptyFuelTankToMoveFor: positionAfterMovement [

	ally
		ifNil: [ self applyPenaltyForEmptyFuelTank ]
		ifNotNil: [ self handleAllyFuelToMoveFor: positionAfterMovement ]
]

{ #category : #initialization }
SpaceShip >> initialize: aName withMaxFuel: anAmount [

	name := aName.
	position := SpaceShipPosition createAt: 1 and: 1.
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

	^ position lap
]

{ #category : #playing }
SpaceShip >> losesTurns: amountOfTurns [

	turnsToLose := turnsToLose + amountOfTurns
]

{ #category : #playing }
SpaceShip >> moveTo: positionAfterMovement needing: amountOfFuelNeeded [

	needsToThrow = 0 ifFalse: [ ^ self ].
	self checkLeakPenaltyToDecreaseFuel: amountOfFuelNeeded.

	fuelTank isEmpty
		ifTrue: [ self handleEmptyFuelTankToMoveFor: positionAfterMovement ]
		ifFalse: [ self moveToNextPostion: positionAfterMovement ]
]

{ #category : #playing }
SpaceShip >> moveToNextPostion: positionAfterMovement [

	position := positionAfterMovement
]

{ #category : #accessing }
SpaceShip >> name [

	^ name
]

{ #category : #initialization }
SpaceShip >> nitroTurns [

	^ nitroTurns
]

{ #category : #'accessing - arguments' }
SpaceShip >> position [

	^ position
]

{ #category : #'accessing - arguments' }
SpaceShip >> resetPosition [

	position resetPosition
]

{ #category : #playing }
SpaceShip >> rollDiceUsing: aDiceRoller [

	| rolledNumber |
	rolledNumber := aDiceRoller roll.
	self checkForRollInHyperGravity: rolledNumber.
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

	^ position tileNumber
]

{ #category : #accessing }
SpaceShip >> turnsToLose [

	^ turnsToLose
]
