Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'laps',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValidQuantityOf: parsecs [

	parsecs < 0 ifTrue: [
		Error signal: 'Parsecs cannot be a negative measure' ]
]

{ #category : #asserting }
Board class >> isValid: tiles [

	tiles size < 2 ifTrue: [ Error signal: 'Tiles should be 2 or more' ]
]

{ #category : #'instance creation' }
Board class >> of: tiles withMeasures: units [

	self isValid: tiles.
	self assertValidQuantityOf: units valueAsParsecs.
	^ self new initializeOf: tiles withDistance: units
]

{ #category : #initialization }
Board >> amountOfTiles [

	^ tiles size
]

{ #category : #initialization }
Board >> effectToApplyTo: aSpaceship [

	^ tiles at: aSpaceship tileNumber
]

{ #category : #playing }
Board >> finishesAfter: amountOfLaps [

	laps := amountOfLaps
]

{ #category : #initialization }
Board >> initializeOf: aTileCollection withDistance: aUnitOfDistance [

	tiles := aTileCollection.
	parsecs := aUnitOfDistance valueAsParsecs
]

{ #category : #accessing }
Board >> laps [

	^ laps
]

{ #category : #accessing }
Board >> move: aSpaceship by: anAmountOfTilesToMove [

	| tilesSinceBeginning positionAfterMovement tileAfterMovement lapAfterMovement amountOfFuelNeeded |
	tilesSinceBeginning := (aSpaceship position
		                        totalAmountOfSquaresMovedWith:
		                        self amountOfTiles) + anAmountOfTilesToMove.

	tileAfterMovement := tilesSinceBeginning - 1 % self amountOfTiles + 1.
	lapAfterMovement := tilesSinceBeginning - 1 // self amountOfTiles + 1.

	positionAfterMovement := SpaceShipPosition
		                         createAt: tileAfterMovement
		                         and: lapAfterMovement.
	positionAfterMovement correctIfBeyond: laps + 1.
	amountOfFuelNeeded := aSpaceship position
		                      costToMoveTo: positionAfterMovement
		                      withBoardSize: self amountOfTiles.
	aSpaceship moveTo: positionAfterMovement needing: amountOfFuelNeeded
]

{ #category : #initialization }
Board >> move: aSpaceship jumping: aQuantityOfParsec [

	| tilesToMove |
	tilesToMove := (aQuantityOfParsec // (parsecs / self amountOfTiles))
		               truncated.

	self move: aSpaceship by: tilesToMove
]

{ #category : #accessing }
Board >> move: aSpaceship toTile: tileToTeleport [

	self move: aSpaceship by: tileToTeleport - aSpaceship tileNumber
]

{ #category : #initialization }
Board >> moveAllSpaceshipsToFirstPosition: allSpaceShips [

	allSpaceShips do: [ :spaceship | spaceship resetPosition ]
]
